import Foundation

extension InstructionSet {
  static let TAB = [
    Instruction(
      opCode: 0x16,
      mnemonic: .TAB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, _, _, _, _, _) = p.tuple()
        
        p.CC.update(R: A)
        p.B = A
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
