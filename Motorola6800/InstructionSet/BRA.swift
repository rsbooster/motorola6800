import Foundation

extension InstructionSet {
  static let BRA = [
    Instruction(
      opCode: 0x24,
      mnemonic: .BCC,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: !p.CC.C, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x25,
      mnemonic: .BCS,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.C, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x27,
      mnemonic: .BEQ,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.Z, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x2C,
      mnemonic: .BGE,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.N == p.CC.V, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x2E,
      mnemonic: .BGT,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: !p.CC.Z && (p.CC.N == p.CC.V), PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x22,
      mnemonic: .BHI,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: !p.CC.C && !p.CC.Z, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x2F,
      mnemonic: .BLE,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.Z || (p.CC.N != p.CC.V), PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x23,
      mnemonic: .BLS,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.C || p.CC.Z, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x2D,
      mnemonic: .BLT,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.N != p.CC.V, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x2B,
      mnemonic: .BMI,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.N, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x26,
      mnemonic: .BNE,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: !p.CC.Z, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x2A,
      mnemonic: .BPL,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: !p.CC.N, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x20,
      mnemonic: .BRA,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: true, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x28,
      mnemonic: .BVC,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: !p.CC.V, PC: &p.PC, memory: m)
      }
    ),
    Instruction(
      opCode: 0x29,
      mnemonic: .BVS,
      addressingMode: .relative,
      executionTime: 4,
      action: { p, m in
        branch(condition: p.CC.V, PC: &p.PC, memory: m)
      }
    ),
  ]
}

private func branch(condition: Bool, PC: inout UInt16, memory: Memory) {
  if condition {
    let offset = memory.readByte(PC + 1)
    PC = (PC + 2).addingSigned(offset)
  } else {
    PC += 2
  }
}
