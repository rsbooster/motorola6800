import Foundation

extension InstructionSet {
  static let TXS = [
    Instruction(
      opCode: 0x35,
      mnemonic: .TXS,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, _ in
        let (_, _, X, _, _, _) = p.tuple()
        
        p.SP = X &- 1
        p.PC += 1
      }
    ),
  ]
}
