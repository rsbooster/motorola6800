import Foundation

extension InstructionSet {
  static let CBA = [
    Instruction(
      opCode: 0x11,
      mnemonic: .CBA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, m in
        let (A, B, _, _, _, CC) = p.tuple()
        
        let R = A &- B
        
        p.PC += 1
        
        p.CC.N = R[7]
        p.CC.Z = R == 0
        p.CC.V = isOverflow(B[7], R[7], A[7])
        p.CC.C = isCarry(B[7], R[7], A[7])
      }
    )
  ]
}

