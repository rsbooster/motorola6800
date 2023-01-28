import Foundation

extension InstructionSet {
  static let SUB = [
    Instruction(
      opCode: 0x80,
      mnemonic: .SUBA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x90,
      mnemonic: .SUBA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB0,
      mnemonic: .SUBA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA0,
      mnemonic: .SUBA,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, _, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = A &- M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xC0,
      mnemonic: .SUBB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xD0,
      mnemonic: .SUBB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF0,
      mnemonic: .SUBB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE0,
      mnemonic: .SUBB,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (_, B, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = B &- M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
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
