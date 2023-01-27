import Foundation

extension InstructionSet {
  static let SEV = [
    Instruction(
      opCode: 0x0B,
      mnemonic: .SEV,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.CC.V = true
        p.PC += 1
      }
    )
  ]
}

