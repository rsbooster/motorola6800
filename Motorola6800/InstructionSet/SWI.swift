import Foundation

extension InstructionSet {
  static let SWI = [
    Instruction(
      opCode: 0x3F,
      mnemonic: .SWI,
      addressingMode: .inherent,
      executionTime: 12,
      action: { p, m in
        let (A, B, _, _, _, CC) = p.tuple()
        
        p.PC += 1
        
        m.pushWord(stackPointer: &p.SP, value: p.PC)
        m.pushWord(stackPointer: &p.SP, value: p.X)
        m.pushByte(stackPointer: &p.SP, value: A)
        m.pushByte(stackPointer: &p.SP, value: B)
        m.pushByte(stackPointer: &p.SP, value: CC.asByte)
        
        p.CC.I = true
        
        p.PC = m.readWord(0xFFFA)
      }
    )
  ]
}

