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
        
        let offset = m.readByte(PC + 1)
        let negative = offset[7]
        let value: UInt8
        
        if negative {
          value = 0xFF - offset
        } else {
          value = offset
        }
        
        if CC.C {
          p.PC += 2
        } else if negative {
          p.PC = PC + 2 - UInt16(value)
        } else {
          p.PC = PC + 2 + UInt16(value)
        }
      }
    ),
  ]
}
