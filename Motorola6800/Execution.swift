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
    CC: .init(H: false, N: false, Z: false, V: false, C: false)
  )
  var memory = initialMemory
  
  processor.PC = UInt16(memory.readWord(0xFFFE))
  
  while(true) {
    let opCode = memory.readByte(processor.PC)
    let instruction = instructionMap[opCode]!
    
    instruction.action(&processor, &memory)
  }
}

private let initialMemory: [UInt8] = {
  let memoryStart: [UInt8] = [
    0x86, 0x01,
    0xC6, 0x02,
    
    0x1B,
    
    0x3E,
  ]
  
  let memoryEnd: [UInt8] = [
    0x00, 0x00
  ]
  
  return memoryStart
    + Array(repeating: 0, count: 65536 - memoryStart.count - memoryEnd.count)
    + memoryEnd
}()
