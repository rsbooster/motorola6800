import Foundation

extension InstructionSet {
  static let JMP = [
    Instruction(
      opCode: 0x7E,
      mnemonic: .JMP,
      addressingMode: .extended,
      executionTime: 3,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let address = m.readWord(PC + 1)
        
        p.PC = address
      }
    ),
    Instruction(
      opCode: 0x6E,
      mnemonic: .JMP,
      addressingMode: .extended,
      executionTime: 3,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let offset = m.readByte(PC + 1)
        
        p.PC = X + UInt16(offset)
      }
    ),
  ]
}
