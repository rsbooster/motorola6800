import Foundation

extension InstructionSet {
  static let BCC = [
    Instruction(
      opCode: 0x24,
      mnemonic: .BCC,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        if CC.C {
          p.PC += 2
        } else  {
          let offset = m.readByte(PC + 1)
          p.PC = (PC + 2).addingSigned(offset)
        }
      }
    ),
  ]
}
