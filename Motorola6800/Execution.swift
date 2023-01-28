import Foundation

func execute() {
  let instructionMap = Dictionary(
    uniqueKeysWithValues: InstructionSet.all.map { ($0.opCode, $0 )}
  )
  var processor = Processor(
    A: 0,
    B: 0,
    X: 0,
    PC: 0,
    SP: 0,
    CC: .init(H: false, I: false, N: false, Z: false, V: false, C: false),
    emulated: .init(waitingForInterrupt: false)
  )
  var memory = initialMemory
  
  processor.PC = memory.readWord(0xFFFE)
  
  while(true) {
    if !processor.emulated.waitingForInterrupt {
      print(processor.description)
      
      let opCode = memory.readByte(processor.PC)
      let instruction = instructionMap[opCode]!
      
      instruction.action(&processor, &memory)
    }
    Thread.sleep(forTimeInterval: 1e-6)
  }
}

private let initialMemory: Memory = {
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
