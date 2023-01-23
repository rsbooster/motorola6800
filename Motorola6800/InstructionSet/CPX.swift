import Foundation

extension InstructionSet {
  static let CPX = [
    Instruction(
      opCode: 0x8C,
      mnemonic: .CPX,
      addressingMode: .immediate,
      executionTime: 3,
      action: { p, m in
        let M = m.readWord(p.PC + 1)
        p.cpx(M: M)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x9C,
      mnemonic: .CPX,
      addressingMode: .direct,
      executionTime: 4,
      action: { p, m in
        let (M, _) = m.readOperandDirect16(p.PC + 1)
        p.cpx(M: M)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xBC,
      mnemonic: .CPX,
      addressingMode: .extended,
      executionTime: 5,
      action: { p, m in
        let (M, _) = m.readOperandExtended16(p.PC + 1)
        p.cpx(M: M)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xAC,
      mnemonic: .CPX,
      addressingMode: .indexed,
      executionTime: 6,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        
        let (M, _) = m.readOperandIndexed16(PC + 1, X: X)
        p.cpx(M: M)
        
        p.PC += 2
      }
    ),
  ]
}


private extension Processor {
  mutating func cpx(M: UInt16) {
    let RH = X.upper &- M.upper
    let RL = X.lower &- M.lower
    
    CC.N = RH[7]
    CC.Z = (RH == 0 && RL == 0)
    CC.V = isOverflow(RH[7], M.upper[7], X.upper[7])
  }
}

