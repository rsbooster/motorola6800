import Foundation

extension InstructionSet {
  static let WAI = [
    Instruction(
      opCode: 0x3E,
      mnemonic: .WAI,
      addressingMode: .inherent,
      executionTime: 9,
      action: { _, _ in }
    )
  ]
}

