import Foundation

extension InstructionSet {
  static let RTS = [
    Instruction(
      opCode: 0x39,
      mnemonic: .BSR,
      addressingMode: .relative,
      executionTime: 5,
      action: { p, m in
        p.PC = m.pullWord(stackPointer: &p.SP)
      }
    ),
  ]
}
