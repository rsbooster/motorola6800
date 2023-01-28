import Foundation

extension InstructionSet {
  static let TPA = [
    Instruction(
      opCode: 0x07,
      mnemonic: .TPA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (_, _, _, _, _, CC) = p.tuple()
        
        p.A = CC.asByte
        p.PC += 1
      }
    ),
  ]
}
