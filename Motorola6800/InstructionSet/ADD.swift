import Foundation

extension InstructionSet {
  static let ADD = [
    Instruction(
      opCode: 0x8B,
      mnemonic: .ADDA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = A &+ M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x9B,
      mnemonic: .ADDA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = A &+ M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xBB,
      mnemonic: .ADDA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = A &+ M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xAB,
      mnemonic: .ADDA,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, _, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = A &+ M
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xCB,
      mnemonic: .ADDB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = B &+ M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xDB,
      mnemonic: .ADDB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = B &+ M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xFB,
      mnemonic: .ADDB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = B &+ M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xEB,
      mnemonic: .ADDB,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (_, B, X, PC, _, _) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = B &+ M
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
  ]
}


private extension Processor.ConditionCodes {
  mutating func update(X: UInt8, M: UInt8, R: UInt8) {
    H = isCarry(X[3], M[3], R[3])
    N = R[7]
    Z = R == 0
    V = isOverflow(X[7], M[7], R[7])
    C = isCarry(X[7], M[7], R[7])
  }
}
