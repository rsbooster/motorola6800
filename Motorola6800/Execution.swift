import Foundation
import SwiftUI

final class Execution {
  private let instructionMap: [UInt8: Instruction]
  private var processor: Processor
  private var memory: Memory
  
  private var logging = false
  private lazy var timer = Timer.scheduledTimer(
    withTimeInterval: 1e-6,
    repeats: true,
    block: { [weak self] _ in
      self?.step()
    }
  )
  
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
    if !processor.emulated.waitingForInterrupt {
      if logging {
        print(processor.description)
      }
      
      let opCode = memory.readByte(processor.PC)
      let instruction = instructionMap[opCode]!
      
      instruction.action(&processor, &memory)
    }
  }
  
  func run() {
    RunLoop.main.add(timer, forMode: .common)
  }
  
  func reset() {
    processor.PC = memory.readWord(0xFFFE)
  }
  
  deinit {
    timer.invalidate()
  }
}

private let defaultInstructions = Dictionary(
  uniqueKeysWithValues: InstructionSet.all.map { ($0.opCode, $0 )}
)
