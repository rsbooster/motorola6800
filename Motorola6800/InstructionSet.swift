import Foundation

enum InstructionSet {}

extension InstructionSet {
  static let all = InstructionSet.ABA
    + InstructionSet.ADD
    + InstructionSet.ADC
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
    + InstructionSet.DES
    + InstructionSet.DEX
    + InstructionSet.EOR
    + InstructionSet.INC
    + InstructionSet.INS
    + InstructionSet.INX
    + InstructionSet.JMP
    + InstructionSet.JSR
    + InstructionSet.LDA
    + InstructionSet.LDS
    + InstructionSet.LDX
    + InstructionSet.LSR
    + InstructionSet.NEG
    + InstructionSet.NOP
    + InstructionSet.ORA
    + InstructionSet.PSH
    + InstructionSet.PUL
    + InstructionSet.ROL
    + InstructionSet.ROR
    + InstructionSet.RTI
    + InstructionSet.RTS
    + InstructionSet.SBA
    + InstructionSet.SBC
    + InstructionSet.SEC
    + InstructionSet.SEI
    + InstructionSet.SEV
    + InstructionSet.STA
    + InstructionSet.STS
    + InstructionSet.WAI
}
