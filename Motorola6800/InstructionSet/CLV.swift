import Foundation

extension InstructionSet {
  static let CLV = [
    Instruction(
      opCode: 0x0A,
      mnemonic: .CLV,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.CC.V = false
        p.PC += 1
      }
    )
  ]
}

