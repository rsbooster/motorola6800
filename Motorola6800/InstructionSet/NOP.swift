import Foundation

extension InstructionSet {
  static let NOP = [
    Instruction(
      opCode: 0x01,
      mnemonic: .NOP,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.PC += 1
      }
    ),
  ]
}
