import Foundation

extension InstructionSet {
  static let SEC = [
    Instruction(
      opCode: 0x0D,
      mnemonic: .SEC,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.CC.C = true
        p.PC += 1
      }
    )
  ]
}

