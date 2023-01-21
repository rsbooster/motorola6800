import Foundation

extension InstructionSet {
  static let CLC = [
    Instruction(
      opCode: 0x0C,
      mnemonic: .CLC,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.CC.C = false
        p.PC += 1
      }
    )
  ]
}

