import Foundation

extension InstructionSet {
  static let PUL = [
    Instruction(
      opCode: 0x32,
      mnemonic: .PULA,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, m in
        p.A = m.pullByte(stackPointer: &p.SP)
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x33,
      mnemonic: .PULB,
      addressingMode: .inherent,
      executionTime: 4,
      action: { p, m in
        p.B = m.pullByte(stackPointer: &p.SP)
        p.PC += 1
      }
    )
  ]
}

