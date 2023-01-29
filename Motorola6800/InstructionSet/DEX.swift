import Foundation

extension InstructionSet {
  static let DEX = [
    Instruction(
      opCode: 0x09,
      mnemonic: .DEX,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, _ in
        p.X &-= 1
        p.CC.Z = p.X == 0
        p.PC += 1
      }
    ),
  ]
}
