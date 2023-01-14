import Foundation

extension InstructionSet {
  static let COM = [
    Instruction(
      opCode: 0x43,
      mnemonic: .COMA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = 0xFF - A
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x53,
      mnemonic: .COMB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = 0xFF - B
        
        p.updateCC(result: R)
        
        p.B = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x73,
      mnemonic: .COM,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let (value, address) = m.readOperandExtended8(p.PC + 1)
        
        let R = 0xFF - value
        
        p.updateCC(result: R)
        
        m.writeByte(address: address, value: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x63,
      mnemonic: .COM,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let (value, address) = m.readOperandIndexed8(p.PC + 1, X: X)
        
        let R = 0xFF - value
        
        p.updateCC(result: R)
        
        m.writeByte(address: address, value: R)
        
        p.PC += 2
      }
    ),
  ]
}


private extension Processor {
  mutating func updateCC(result R: UInt8) {
    CC.N = R[7]
    CC.Z = R == 0
    CC.V = false
    CC.C = true
  }
}
