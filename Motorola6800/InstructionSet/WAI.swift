import Foundation

extension InstructionSet {
  static let WAI = [
    Instruction(
      opCode: 0x3E,
      mnemonic: .WAI,
      addressingMode: .inherent,
      executionTime: 9,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        p.PC += 1
        
        m.pushWord(stackPointer: &p.SP, value: p.PC)
        m.pushWord(stackPointer: &p.SP, value: p.X)
        m.pushByte(stackPointer: &p.SP, value: A)
        m.pushByte(stackPointer: &p.SP, value: B)
        m.pushByte(stackPointer: &p.SP, value: CC.asByte)
      }
    )
  ]
}

