import Foundation

extension InstructionSet {
  static let TSX = [
    Instruction(
      opCode: 0x30,
      mnemonic: .TSX,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, _ in
        let (_, _, _, _, SP, _) = p.tuple()
        
        p.X = SP &+ 1
        p.PC += 1
      }
    ),
  ]
}
