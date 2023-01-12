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
        p.SP -= 7
        
        m.writeByte(address: p.SP + 7, value: p.PC.lower)
        m.writeByte(address: p.SP + 6, value: p.PC.upper)
        m.writeByte(address: p.SP + 5, value: X.lower)
        m.writeByte(address: p.SP + 4, value: X.upper)
        m.writeByte(address: p.SP + 3, value: A)
        m.writeByte(address: p.SP + 2, value: B)
        m.writeByte(address: p.SP + 1, value: CC.asByte)
      }
    )
  ]
}

