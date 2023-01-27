import Foundation

extension InstructionSet {
  static let STS = [
    Instruction(
      opCode: 0x9F,
      mnemonic: .STS,
      addressingMode: .direct,
      executionTime: 5,
      action: { p, m in
        let (_, _, _, PC, SP, _) = p.tuple()
        
        let address = UInt16(m.readByte(PC + 1))
        m.writeWord(address: address, value: SP)
        p.updateCC(result: SP)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xBF,
      mnemonic: .STS,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (_, _, _, PC, SP, _) = p.tuple()
        
        let address = m.readWord(PC + 1)
        m.writeWord(address: address, value: SP)
        p.updateCC(result: SP)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xAF,
      mnemonic: .STS,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, PC, SP, _) = p.tuple()
        
        let offset = UInt16(m.readByte(PC + 1))
        m.writeWord(address: X + offset, value: SP)
        p.updateCC(result: SP)
        
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
