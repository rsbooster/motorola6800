import Foundation

extension InstructionSet {
  static let JMP = [
    Instruction(
      opCode: 0x7E,
      mnemonic: .JMP,
      addressingMode: .immediate,
      executionTime: 3,
      action: { p, m in
        let (_, _, _, PC, _, _) = p.tuple()
        
        let address = m.readWord(PC + 1)
        
        p.PC = address
      }
    ),
    Instruction(
      opCode: 0x6E,
      mnemonic: .JMP,
      addressingMode: .indexed,
      executionTime: 3,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        
        let offset = UInt16(m.readByte(PC + 1))
        
        p.PC = X &+ offset
      }
    ),
  ]
}
