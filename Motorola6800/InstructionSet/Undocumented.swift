import Foundation

extension InstructionSet {
  static let undocumented = [
    Instruction(
      opCode: 0x14,
      mnemonic: .NBA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, _, _, _, _) = p.tuple()
        let R = A & B
        p.updateCC(X: A, M: B, R: R)
        p.A = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x15,
      mnemonic: .NOP,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x87,
      mnemonic: .STAA,
      addressingMode: .immediate,
      executionTime: 6,
      action: { p, m in
        let (A, _, X, PC, _, _) = p.tuple()
        m.writeByte(address: PC + 2, value: A)
        p.updateCC(result: A)
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xC7,
      mnemonic: .STAB,
      addressingMode: .immediate,
      executionTime: 6,
      action: { p, m in
        let (_, B, X, PC, _, _) = p.tuple()
        m.writeByte(address: PC + 2, value: B)
        p.updateCC(result: B)
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x8F,
      mnemonic: .STS,
      addressingMode: .immediate,
      executionTime: 5,
      action: { p, m in
        let (_, _, _, PC, SP, _) = p.tuple()
        m.writeWord(address: PC + 2, value: SP)
        p.PC += 4
      }
    ),
    Instruction(
      opCode: 0xCF,
      mnemonic: .STX,
      addressingMode: .immediate,
      executionTime: 5,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        m.writeWord(address: PC + 2, value: X)
        p.PC += 4
      }
    ),
    Instruction(
      opCode: 0x9D,
      mnemonic: .HCF,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.emulated.waitingForInterrupt = true
      }
    ),
    Instruction(
      opCode: 0xCD,
      mnemonic: .HCF,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.emulated.waitingForInterrupt = true
      }
    ),
    Instruction(
      opCode: 0xDD,
      mnemonic: .HCF,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.emulated.waitingForInterrupt = true
      }
    ),
    Instruction(
      opCode: 0xED,
      mnemonic: .HCF,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.emulated.waitingForInterrupt = true
      }
    ),
    Instruction(
      opCode: 0xFD,
      mnemonic: .HCF,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.emulated.waitingForInterrupt = true
      }
    ),
  ]
}

private extension Processor {
  mutating func updateCC(result R: UInt8) {
    CC.N = R[7]
    CC.Z = R == 0
    CC.V = false
  }
  
  mutating func updateCC(X: UInt8, M: UInt8, R: UInt8) {
    CC.H = isCarry(X[3], M[3], R[3])
    CC.N = R[7]
    CC.Z = R == 0
    CC.V = isOverflow(X[7], M[7], R[7])
    CC.C = isCarry(X[7], M[7], R[7])
  }
}
