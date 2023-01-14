import Foundation

extension InstructionSet {
  static let LSR = [
    Instruction(
      opCode: 0x44,
      mnemonic: .LSRA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, _, _, _, _, _) = p.tuple()
        
        let R = A >> 1
        
        p.updateCC(result: R, carry: A[7])
        
        p.A = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x54,
      mnemonic: .LSRB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (_, B, _, _, _, _) = p.tuple()
        
        let R = B >> 1
        
        p.updateCC(result: R, carry: B[7])
        
        p.B = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x74,
      mnemonic: .LSR,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (value, address) = m.readOperandExtended8(p.PC + 1)
        
        let R = value >> 1
        
        p.updateCC(result: R, carry: value[7])
        
        m.writeByte(address: address, value: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x64,
      mnemonic: .LSR,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, _, _, _) = p.tuple()
        
        let (value, address) = m.readOperandIndexed8(p.PC + 1, X: X)
        
        let R = value >> 1
        
        p.updateCC(result: R, carry: value[7])
        
        m.writeByte(address: address, value: R)
        
        p.PC += 2
      }
    ),
  ]
}


private extension Processor {
  mutating func updateCC(result R: UInt8, carry: Bool) {
    CC.N = false
    CC.Z = R == 0
    CC.V = carry
    CC.C = carry
  }
}
