import Foundation

extension InstructionSet {
  static let SBC = [
    Instruction(
      opCode: 0x82,
      mnemonic: .SBCA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, _, _, PC, _, CC) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = A &- M &- CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x92,
      mnemonic: .SBCA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, _, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = A &- M &- CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB2,
      mnemonic: .SBCA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = A &- M &- CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA2,
      mnemonic: .SBCA,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, _, X, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = A &- M &- CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xC2,
      mnemonic: .SBCB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (_, B, _, PC, _, CC) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = B &- M &- CC.C.asInt()
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xD2,
      mnemonic: .SBCB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (_, B, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = B &- M &- CC.C.asInt()
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF2,
      mnemonic: .SBCB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = B &- M &- CC.C.asInt()
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE2,
      mnemonic: .SBCB,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (_, B, X, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = B &- M &- CC.C.asInt()
        
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
