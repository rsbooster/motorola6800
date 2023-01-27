import Foundation

extension InstructionSet {
  static let ROR = [
    Instruction(
      opCode: 0x46,
      mnemonic: .RORA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, _, _, _, _, CC) = p.tuple()
        
        let R = (A >> 1) | (CC.C.asInt() << 7)
        
        p.updateCC(result: R, carry: A[0])
        
        p.A = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x56,
      mnemonic: .RORB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (_, B, _, _, _, CC) = p.tuple()
        
        let R = (B >> 1) | (CC.C.asInt() << 7)
        
        p.updateCC(result: R, carry: B[0])
        
        p.B = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x76,
      mnemonic: .ROR,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (value, address) = m.readOperandExtended8(p.PC + 1)
        
        let R = (value >> 1) | (p.CC.C.asInt() << 7)
        
        p.updateCC(result: R, carry: value[0])
        
        m.writeByte(address: address, value: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x66,
      mnemonic: .ROR,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, _, _, CC) = p.tuple()
        
        let (value, address) = m.readOperandIndexed8(p.PC + 1, X: X)
        
        let R = (value >> 1) | (CC.C.asInt() << 7)
        
        p.updateCC(result: R, carry: value[0])
        
        m.writeByte(address: address, value: R)
        
        p.PC += 2
      }
    ),
  ]
}


private extension Processor {
  mutating func updateCC(result R: UInt8, carry: Bool) {
    CC.N = R[7]
    CC.Z = R == 0
    CC.V = R[7] != carry
    CC.C = carry
  }
}
