import Foundation

extension InstructionSet {
  static let INS = [
    Instruction(
      opCode: 0x31,
      mnemonic: .INS,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, _ in
        p.SP += 1
        p.PC += 1
      }
    ),
  ]
}
