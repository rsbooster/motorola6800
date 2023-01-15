import Foundation

extension InstructionSet {
  static let NEG = [
    Instruction(
      opCode: 0x40,
      mnemonic: .NEGA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = 0 &- A
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x50,
      mnemonic: .NEGB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = 0 &- B
        
        p.updateCC(result: R)
        
        p.B = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x70,
      mnemonic: .NEG,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let (value, address) = m.readOperandExtended8(PC + 1)
        
        let R = 0 - value
        
        p.updateCC(result: R)
        
        m.writeByte(address: address, value: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x60,
      mnemonic: .NEG,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let (value, address) = m.readOperandIndexed8(PC + 1, X: X)
        
        let R = 0 - value
        
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
    CC.V = R == 0x80
    CC.C = R != 0
  }
}
