import Foundation

extension InstructionSet {
  static let STX = [
    Instruction(
      opCode: 0xDF,
      mnemonic: .STX,
      addressingMode: .direct,
      executionTime: 5,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        
        let address = UInt16(m.readByte(PC + 1))
        m.writeWord(address: address, value: X)
        p.updateCC(result: X)
        
        p.PC += 2
      }
    ),
    Instruction(
      opCode: 0xFF,
      mnemonic: .STX,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        
        let address = m.readWord(PC + 1)
        m.writeWord(address: address, value: X)
        p.updateCC(result: X)
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0xEF,
      mnemonic: .STX,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        
        let offset = UInt16(m.readByte(PC + 1))
        m.writeWord(address: X + offset, value: X)
        p.updateCC(result: X)
        
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
