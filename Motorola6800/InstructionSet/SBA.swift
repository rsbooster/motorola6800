import Foundation

extension InstructionSet {
  static let SBA = [
    Instruction(
      opCode: 0x10,
      mnemonic: .SBA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = A &- B
        
        p.CC.N = R[7]
        p.CC.Z = R == 0
        p.CC.V = isOverflow(R[7], B[7], A[7])
        p.CC.C = isCarry(R[7], B[7], A[7])
        
        p.A = R
        p.PC += 1
      }
    ),
  ]
}
