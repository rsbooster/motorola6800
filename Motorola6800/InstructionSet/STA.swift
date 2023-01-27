import Foundation

extension InstructionSet {
  static let STA = [
    Instruction(
      opCode: 0x97,
      mnemonic: .STAA,
      addressingMode: .direct,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let address = UInt16(m.readByte(PC + 1))
        m.writeByte(address: address, value: A)
    
        p.updateCC(result: A)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB7,
      mnemonic: .STAA,
      addressingMode: .extended,
      executionTime: 5,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let address = m.readWord(PC + 1)
        m.writeByte(address: address, value: A)
    
        p.updateCC(result: A)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA7,
      mnemonic: .STAA,
      addressingMode: .indexed,
      executionTime: 6,
      action: { p, m in
        let (A, _, X, PC, _, _) = p.tuple()
        
        let offset = UInt16(m.readByte(PC + 1))
        m.writeByte(address: X + offset, value: A)
    
        p.updateCC(result: A)
        
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xD7,
      mnemonic: .STAB,
      addressingMode: .direct,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let address = UInt16(m.readByte(PC + 1))
        m.writeByte(address: address, value: B)
    
        p.updateCC(result: B)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF7,
      mnemonic: .STAB,
      addressingMode: .extended,
      executionTime: 5,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let address = m.readWord(PC + 1)
        m.writeByte(address: address, value: B)
    
        p.updateCC(result: B)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE7,
      mnemonic: .STAB,
      addressingMode: .indexed,
      executionTime: 6,
      action: { p, m in
        let (_, B, X, PC, _, _) = p.tuple()
        
        let offset = UInt16(m.readByte(PC + 1))
        m.writeByte(address: X + offset, value: B)
    
        p.updateCC(result: B)
        
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

