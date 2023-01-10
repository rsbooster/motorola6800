import Foundation

enum InstructionSet {}

extension InstructionSet {
  static let all = InstructionSet.ABA
    + InstructionSet.BCC
    + InstructionSet.BRA
    + InstructionSet.COM
    + InstructionSet.DAA
    + InstructionSet.LDA
    + InstructionSet.JMP
    + InstructionSet.NOP
    + InstructionSet.WAI
}
