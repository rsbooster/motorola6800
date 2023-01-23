import Foundation

enum InstructionSet {}

extension InstructionSet {
  static let all = InstructionSet.ABA
    + InstructionSet.ADD
    + InstructionSet.AND
    + InstructionSet.ASL
    + InstructionSet.ASR
    + InstructionSet.BRA
    + InstructionSet.BIT
    + InstructionSet.BSR
    + InstructionSet.CBA
    + InstructionSet.CLC
    + InstructionSet.CLI
    + InstructionSet.CLR
    + InstructionSet.CLV
    + InstructionSet.CMP
    + InstructionSet.COM
    + InstructionSet.CPX
    + InstructionSet.DAA
    + InstructionSet.DEC
    + InstructionSet.LDA
    + InstructionSet.LDS
    + InstructionSet.LDX
    + InstructionSet.LSR
    + InstructionSet.JMP
    + InstructionSet.NEG
    + InstructionSet.NOP
    + InstructionSet.RTS
    + InstructionSet.WAI
}
