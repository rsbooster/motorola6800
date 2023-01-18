import Foundation

extension InstructionSet {
  static let BIT = [
    Instruction(
      opCode: 0x85,
      mnemonic: .BITA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = A & M
        
        p.CC.update(R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x95,
      mnemonic: .BITA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = A & M
        
        p.CC.update(R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB5,
      mnemonic: .BITA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = A & M
        
        p.CC.update(R: R)
        
        p.A = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA5,
      mnemonic: .BITA,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, _, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = A & M
        
        p.CC.update(R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xC5,
      mnemonic: .BITB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = B & M
        
        p.CC.update(R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xD5,
      mnemonic: .BITB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = B & M
        
        p.CC.update(R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF5,
      mnemonic: .BITB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = B & M
        
        p.CC.update(R: R)
        
        p.B = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE5,
      mnemonic: .BITB,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (_, B, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = B & M
        
        p.CC.update(R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
  ]
}


private extension Processor.ConditionCodes {
  mutating func update(R: UInt8) {
    N = R[7]
    Z = R == 0
    V = false
  }
}
