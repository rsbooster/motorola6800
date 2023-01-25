import Foundation

extension InstructionSet {
  static let DES = [
    Instruction(
      opCode: 0x34,
      mnemonic: .DES,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, _ in
        p.SP -= 1
        p.PC += 1
      }
    ),
  ]
}
