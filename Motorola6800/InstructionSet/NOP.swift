import Foundation

extension InstructionSet {
  static let NOP = [
    Instruction(
      opCode: 0x01,
      mnemonic: .ABA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.PC += 1
      }
    ),
  ]
}
