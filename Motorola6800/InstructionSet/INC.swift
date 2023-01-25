import Foundation

extension InstructionSet {
  static let INC = [
    Instruction(
      opCode: 0x4C,
      mnemonic: .INCA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, _, _, _, _, _) = p.tuple()
        
        let R = A &+ 1
        
        p.updateCC(result: R)
        
        p.A = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x5C,
      mnemonic: .INCB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (_, B, _, _, _, _) = p.tuple()
        
        let R = B &+ 1
        
        p.updateCC(result: R)
        
        p.B = R
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x7C,
      mnemonic: .INC,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (value, address) = m.readOperandExtended8(p.PC + 1)
        
        let R = value &+ 1
        
        p.updateCC(result: R)
        
        m.writeByte(address: address, value: R)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x6C,
      mnemonic: .INC,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, _, _, _) = p.tuple()
        
        let (value, address) = m.readOperandIndexed8(p.PC + 1, X: X)
        
        let R = value &+ 1
        
        p.updateCC(result: R)
        
        m.writeByte(address: address, value: R)
        
        p.PC += 2
      }
    ),
  ]
}


private extension Processor {
  mutating func updateCC(result R: UInt8) {
    CC.N = R[7]
    CC.Z = R == 0
    CC.V = R == 0x7F
  }
}

