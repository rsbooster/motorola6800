import Foundation

extension InstructionSet {
  static let TST = [
    Instruction(
      opCode: 0x4D,
      mnemonic: .TSTA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, _, _, _, _, _) = p.tuple()
        
        p.updateCC(result: A)
        
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x5D,
      mnemonic: .TSTB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (_, B, _, _, _, _) = p.tuple()
        
        p.updateCC(result: B)
        
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x7D,
      mnemonic: .TST,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let value: UInt8 = m.readOperandExtended(p.PC + 1)
        
        p.updateCC(result: value)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x6D,
      mnemonic: .TST,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, _, _, _) = p.tuple()
        
        let value: UInt8 = m.readOperandIndexed(p.PC + 1, X: X)
        
        p.updateCC(result: value)
        
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
    CC.C = false
  }
}
