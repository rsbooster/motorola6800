import Foundation

extension InstructionSet {
  static let LDX = [
    Instruction(
      opCode: 0xCE,
      mnemonic: .LDX,
      addressingMode: .immediate,
      executionTime: 3,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R = m.readWord(PC + 1)
        
        p.updateCC(result: R)
        
        p.X = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xDE,
      mnemonic: .LDX,
      addressingMode: .direct,
      executionTime: 4,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R: UInt16 = m.readOperandDirect(PC + 1)
        
        p.updateCC(result: R)
        
        p.X = R
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xFE,
      mnemonic: .LDX,
      addressingMode: .extended,
      executionTime: 5,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R: UInt16 = m.readOperandExtended(PC + 1)
        
        p.updateCC(result: R)
        
        p.X = R
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xEE,
      mnemonic: .LDX,
      addressingMode: .indexed,
      executionTime: 6,
      action: { p, m in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let R: UInt16 = m.readOperandIndexed(PC + 1, X: X)
        
        p.updateCC(result: R)
        
        p.X = R
        p.PC += 2
      }
    ),
  ]
}

private extension Processor {
  mutating func updateCC(result R: UInt16) {
    CC.N = R[15]
    CC.Z = R == 0
    CC.V = false
  }
}
