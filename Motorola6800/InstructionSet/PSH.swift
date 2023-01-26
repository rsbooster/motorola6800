import Foundation

extension InstructionSet {
  static let PSH = [
    Instruction(
      opCode: 0x36,
      mnemonic: .PSHA,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, _, SP, CC) = p.tuple()
        
        m.pushByte(stackPointer: &p.SP, value: A)
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x37,
      mnemonic: .PSHB,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, _, SP, CC) = p.tuple()
        
        m.pushByte(stackPointer: &p.SP, value: B)
        p.PC += 1
      }
    )
  ]
}

