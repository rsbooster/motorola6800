import Foundation

extension InstructionSet {
  static let TBA = [
    Instruction(
      opCode: 0x17,
      mnemonic: .TBA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (_, B, _, _, _, _) = p.tuple()
        
        p.CC.update(R: B)
        p.A = B
        p.PC += 1
      }
    ),
  ]
}

private extension Processor.ConditionCodes {
  mutating func update(R: UInt8) {
    N = R[7]
    Z = R == 0
    V = false
  }
}
