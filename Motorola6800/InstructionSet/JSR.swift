import Foundation

extension InstructionSet {
  static let JSR = [
    Instruction(
      opCode: 0xBD,
      mnemonic: .JSR,
      addressingMode: .extended,
      executionTime: 9,
      action: { p, m in
        let (_, _, _, PC, SP, _) = p.tuple()
        
        m.pushWord(stackPointer: &p.SP, value: PC + 3)
        p.PC = m.readWord(PC + 1)
      }
    ),
    Instruction(
      opCode: 0xAD,
      mnemonic: .JSR,
      addressingMode: .indexed,
      executionTime: 8,
      action: { p, m in
        let (_, _, X, PC, SP, _) = p.tuple()
        
        m.pushWord(stackPointer: &p.SP, value: PC + 2)
        
        let offset = UInt16(m.readByte(PC + 1))
        p.PC = X &+ offset
      }
    ),
  ]
}
