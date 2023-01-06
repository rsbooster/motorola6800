import Foundation

extension InstructionSet {
  static let LDA = [
    Instruction(
      opCode: 0x86,
      mnemonic: .LDAA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = m.readByte(PC + 1)
        
        p.CC.N = R[7]
        p.CC.Z = R == 0
        p.CC.V = false
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xC6,
      mnemonic: .LDAB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = m.readByte(PC + 1)
        
        p.CC.N = R[7]
        p.CC.Z = R == 0
        p.CC.V = false
        
        p.B = R
        p.PC += 2
      }
    ),
  ]
}

