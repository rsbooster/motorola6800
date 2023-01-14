import Foundation

extension InstructionSet {
  static let JMP = [
    Instruction(
      opCode: 0x7E,
      mnemonic: .JMP,
      addressingMode: .immediate,
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
      addressingMode: .indexed,
      executionTime: 3,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        p.PC = m.readOperandIndexed(PC + 1, X: X)
      }
    ),
  ]
}
