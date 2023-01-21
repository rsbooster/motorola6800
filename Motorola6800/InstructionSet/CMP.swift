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
        
        p.updateCC(A: R, B: M, R: A)
        
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
        
        let (M, _) = m.readOperandDirect8(PC + 1)
        let R = A &- M
        
        p.updateCC(A: R, B: M, R: A)
        
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
        
        let (M, _) = m.readOperandExtended8(PC + 1)
        let R = A &- M
        
        p.updateCC(A: R, B: M, R: A)
        
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
        
        let (M, _) = m.readOperandIndexed8(PC + 1, X: X)
        let R = A &- M
        
        p.updateCC(A: R, B: M, R: A)
        
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
        
        p.updateCC(A: R, B: M, R: B)
        
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
        
        let (M, _) = m.readOperandDirect8(PC + 1)
        let R = B &- M
        
        p.updateCC(A: R, B: M, R: B)
        
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
        
        let (M, _) = m.readOperandExtended8(PC + 1)
        let R = B &- M
        
        p.updateCC(A: R, B: M, R: B)
        
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
        
        let (M, _) = m.readOperandIndexed8(PC + 1, X: X)
        let R = B &- M
        
        p.updateCC(A: R, B: M, R: B)
        
        p.PC += 2
      }
    ),
  ]
}


private extension Processor {
  mutating func updateCC(A: UInt8, B: UInt8, R: UInt8) {
    CC.N = R[7]
    CC.Z = R == 0
    CC.V = isOverflow(A[7], B[7], R[7])
    CC.C = isCarry(A[7], B[7], R[7])
  }
}
