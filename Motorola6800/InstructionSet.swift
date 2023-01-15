import Foundation

enum InstructionSet {}

extension InstructionSet {
  static let all = InstructionSet.ABA
    + InstructionSet.ADD
    + InstructionSet.AND
    + InstructionSet.BRA
    + InstructionSet.COM
    + InstructionSet.DAA
    + InstructionSet.LDA
    + InstructionSet.LDS
    + InstructionSet.LDX
    + InstructionSet.LSR
    + InstructionSet.JMP
    + InstructionSet.NEG
    + InstructionSet.NOP
    + InstructionSet.WAI
}
