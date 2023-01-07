import Foundation

extension InstructionSet {
  static let LDA = [
    Instruction(
      opCode: 0x86,
      mnemonic: .LDAA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = m.readByte(PC + 1)
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x96,
      mnemonic: .LDAA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let address = m.readByte(PC + 1)
        let R = m.readByte(UInt16(address))
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB6,
      mnemonic: .LDAA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let address = m.readWord(PC + 1)
        let R = m.readByte(address)
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA6,
      mnemonic: .LDAA,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let offset = m.readByte(PC + 1)
        let R = m.readByte(X + UInt16(offset))
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xC6,
      mnemonic: .LDAB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = m.readByte(PC + 1)
        
        p.updateCC(result: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xD6,
      mnemonic: .LDAB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let address = m.readByte(PC + 1)
        let R = m.readByte(UInt16(address))
        
        p.updateCC(result: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF6,
      mnemonic: .LDAB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let address = m.readWord(PC + 1)
        let R = m.readByte(address)
        
        p.updateCC(result: R)
        
        p.B = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE6,
      mnemonic: .LDAB,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let offset = m.readByte(PC + 1)
        let R = m.readByte(X + UInt16(offset))
        
        p.updateCC(result: R)
        
        p.B = R
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
  }
}
