import Foundation

extension InstructionSet {
  static let CMP = [
    Instruction(
      opCode: 0x81,
      mnemonic: .CMPA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x91,
      mnemonic: .CMPA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB1,
      mnemonic: .CMPA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA1,
      mnemonic: .CMPA,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (A, _, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xC1,
      mnemonic: .CMPB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xD1,
      mnemonic: .CMPB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF1,
      mnemonic: .CMPB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE1,
      mnemonic: .CMPB,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, B, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.PC += 2
      }
    ),
  ]
}

private extension Processor.ConditionCodes {
  mutating func update(X: UInt8, M: UInt8, R: UInt8) {
    N = R[7]
    Z = R == 0
    V = isOverflow(R[7], M[7], X[7])
    C = isCarry(R[7], M[7], X[7])
  }
}
