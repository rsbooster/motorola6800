import Foundation

extension InstructionSet {
  static let CLI = [
    Instruction(
      opCode: 0x0E,
      mnemonic: .CLI,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.CC.I = false
        p.PC += 1
      }
    )
  ]
}

