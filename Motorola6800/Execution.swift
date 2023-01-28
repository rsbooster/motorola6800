import Foundation

final class Execution {
  let instructionMap: [UInt8: Instruction]
  private(set) var processor: Processor
  private(set) var memory: Memory
  
  init(
    instructionMap: [UInt8: Instruction],
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
    
    processor.PC = memory.readWord(0xFFFE)
  }
  
  func step() {
    if !processor.emulated.waitingForInterrupt {
      print(processor.description)
      
      let opCode = memory.readByte(processor.PC)
      let instruction = instructionMap[opCode]!
      
      instruction.action(&processor, &memory)
    }
  }
}

func execute() {
  let execution = Execution(
    instructionMap: Dictionary(
      uniqueKeysWithValues: InstructionSet.all.map { ($0.opCode, $0 )}
    ),
    memory: et3400rom
  )
  
  let timer = Timer.scheduledTimer(
    withTimeInterval: 1e-6,
    repeats: true,
    block: { _ in execution.step() }
  )
  RunLoop.main.add(timer, forMode: .common)
}

private let sampleProgram: Memory = {
  let memoryStart: [UInt8] = [
    0x86, 0xFF,
    0xC6, 0xFE,
    
    0x40,
    0x50,
    
    0x1B,
    
    0x19,
    
    0x24, 0xFC,
    
    0x8E, 0x80, 0x00,
    
    0x3E,
  ]
  
  let memoryEnd: [UInt8] = [
    0x00, 0x00
  ]
  
  let content = memoryStart
    + Array(repeating: 0, count: 65536 - memoryStart.count - memoryEnd.count)
    + memoryEnd
  
  return Memory(content: content, romSize: 1024)
}()

private let et3400rom: Memory = {
  let url = Bundle.main.url(forResource: "et3400rom", withExtension: "bin")!
  let rom = try! Data(contentsOf: url)
  let content = Array(repeating: 0, count: 65536 - rom.count)
    + rom
  return Memory(content: content, romSize: 1024)
}()
