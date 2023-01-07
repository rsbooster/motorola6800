import Foundation

extension InstructionSet {
  static let BRA = [
    Instruction(
      opCode: 0x20,
      mnemonic: .BRA,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let offset = m.readByte(PC + 1)
        p.PC = (PC + 2).addingSigned(offset)
      }
    ),
  ]
}
