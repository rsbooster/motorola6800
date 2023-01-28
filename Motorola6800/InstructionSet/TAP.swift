import Foundation

extension InstructionSet {
  static let TAP = [
    Instruction(
      opCode: 0x06,
      mnemonic: .TAP,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, _, _, _, _, _) = p.tuple()
        
        p.CC = .fromByte(A)
        p.PC += 1
      }
    ),
  ]
}
