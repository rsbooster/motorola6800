import Foundation

extension InstructionSet {
  static let ADC = [
    Instruction(
      opCode: 0x89,
      mnemonic: .ADCA,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (A, _, _, PC, _, CC) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = A + M + CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0x99,
      mnemonic: .ADCA,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (A, _, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = A + M + CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xB9,
      mnemonic: .ADCA,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (A, _, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = A + M + CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xA9,
      mnemonic: .ADCA,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (A, _, X, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = A + M + CC.C.asInt()
        
        p.CC.update(X: A, M: M, R: R)
        
        p.A = R
        p.PC += 2
      }
    ),
    
    Instruction(
      opCode: 0xC9,
      mnemonic: .ADCB,
      addressingMode: .immediate,
      executionTime: 2,
      action: { p, m in
        let (_, B, _, PC, _, CC) = p.tuple()
        
        let M = m.readByte(PC + 1)
        let R = B + M + CC.C.asInt()
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xD9,
      mnemonic: .ADCB,
      addressingMode: .direct,
      executionTime: 3,
      action: { p, m in
        let (_, B, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandDirect(PC + 1)
        let R = B + M + CC.C.asInt()
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xF9,
      mnemonic: .ADCB,
      addressingMode: .extended,
      executionTime: 4,
      action: { p, m in
        let (_, B, _, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandExtended(PC + 1)
        let R = B + M + CC.C.asInt()
        
        p.CC.update(X: B, M: M, R: R)
        
        p.B = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xE9,
      mnemonic: .ADCB,
      addressingMode: .indexed,
      executionTime: 5,
      action: { p, m in
        let (_, B, X, PC, _, CC) = p.tuple()
        
        let M: UInt8 = m.readOperandIndexed(PC + 1, X: X)
        let R = B + M + CC.C.asInt()
        
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
