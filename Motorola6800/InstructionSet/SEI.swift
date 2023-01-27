import Foundation

extension InstructionSet {
  static let SEI = [
    Instruction(
      opCode: 0x0F,
      mnemonic: .SEI,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.CC.I = true
        p.PC += 1
      }
    )
  ]
}

