import Foundation

extension InstructionSet {
  static let RTI = [
    Instruction(
      opCode: 0x3B,
      mnemonic: .WAI,
      addressingMode: .inherent,
      executionTime: 10,
      action: { p, m in
        
        p.CC = .fromByte(m.pullByte(stackPointer: &p.SP))
        p.B = m.pullByte(stackPointer: &p.SP)
        p.A = m.pullByte(stackPointer: &p.SP)
        p.X = m.pullWord(stackPointer: &p.SP)
        p.PC = m.pullWord(stackPointer: &p.SP)
      }
    )
  ]
}

