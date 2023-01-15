import Foundation

extension InstructionSet {
  static let ABA = [
    Instruction(
      opCode: 0x1B,
      mnemonic: .ABA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = A &+ B
        
        p.CC = Processor.ConditionCodes(
          H: isCarry(A[3], B[3], R[3]),
          N: R[7],
          Z: R == 0,
          V: isOverflow(A[7], B[7], R[7]),
          C: isCarry(A[7], B[7], R[7])
        )
        p.A = R
        p.PC += 1
      }
    ),
  ]
}
