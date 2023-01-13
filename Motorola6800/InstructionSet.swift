import Foundation

enum InstructionSet {}

extension InstructionSet {
  static let all = InstructionSet.ABA
    + InstructionSet.BCC
    + InstructionSet.BRA
    + InstructionSet.COM
    + InstructionSet.DAA
    + InstructionSet.LDA
    + InstructionSet.LDS
    + InstructionSet.JMP
    + InstructionSet.NEG
    + InstructionSet.NOP
    + InstructionSet.WAI
}
