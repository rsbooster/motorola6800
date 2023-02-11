import Foundation

final class Execution {
  private let instructionMap: [UInt8: Instruction]
  private var processor: Processor
  private var memory: Memory
  
  private var logging = false
  private var timer: Timer? {
    didSet {
      oldValue?.invalidate()
      if let timer {
        RunLoop.main.add(timer, forMode: .common)
      }
    }
  }
  
  private var performanceCounter: (time: DispatchTime, cycles: UInt64) = (.now(), cycleCount)
  private var updateFrequency: (UInt64) -> Void = { _ in }
  private var remainingOpCycles: UInt8 = 0
   
  init(
    instructionMap: [UInt8: Instruction] = defaultInstructions,
    memory: Memory
  ) {
    self.instructionMap = instructionMap
    self.memory = memory
    self.processor = Processor(
      A: 0,
      B: 0,
      X: 0,
      PC: 0,
      SP: 0,
      CC: .init(H: false, I: false, N: false, Z: false, V: false, C: false),
      emulated: .init(waitingForInterrupt: false)
    )
    reset()
  }
  
  func step() {
    guard !processor.emulated.waitingForInterrupt else {
      return
    }
    
    memory.tick()
    updatePerformanceCounter()
    
    guard remainingOpCycles == 0 else {
      remainingOpCycles -= 1
      return
    }
    
    if logging {
      print(processor.description)
    }
    
    let opCode = memory.readByte(processor.PC)
    guard let instruction = instructionMap[opCode] else {
      reset()
      return
    }
    instruction.action(&processor, &memory)
    remainingOpCycles = instruction.executionTime
  }
  
  private func updatePerformanceCounter(elapsedCycles: UInt8 = 1) {
    if performanceCounter.cycles <= elapsedCycles {
      let frequency = cycleCount * UInt64(10e9) / (DispatchTime.now().uptimeNanoseconds - performanceCounter.time.uptimeNanoseconds)
      updateFrequency(frequency)
      performanceCounter = (.now(), cycleCount)
    } else {
      performanceCounter.cycles -= UInt64(elapsedCycles)
    }
  }
  
  private func makeTimer() -> Timer {
    Timer.scheduledTimer(
      withTimeInterval: 1e-5,
      repeats: true,
      block: { [weak self] _ in
        self?.step()
      }
    )
  }
  
  func run(updateFrequency: @escaping (UInt64) -> Void) {
    self.updateFrequency = updateFrequency
    self.timer = makeTimer()
  }
  
  func stop() {
    timer = nil
  }
  
  func reset() {
    processor.PC = memory.readWord(0xFFFE)
    processor.emulated.waitingForInterrupt = false
  }
  
  deinit {
    timer = nil
  }
}

private let defaultInstructions = Dictionary(
  uniqueKeysWithValues: InstructionSet.all.map { ($0.opCode, $0 )}
)

private let cycleCount: UInt64 = 100_000
