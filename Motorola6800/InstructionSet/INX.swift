import Foundation

extension InstructionSet {
  static let INX = [
    Instruction(
      opCode: 0x08,
      mnemonic: .INX,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, _ in
        p.X &+= 1
        p.CC.Z = p.X == 0
        p.PC += 1
      }
    ),
  ]
}
