import Foundation

extension InstructionSet {
  static let BSR = [
    Instruction(
      opCode: 0x8D,
      mnemonic: .BSR,
      addressingMode: .relative,
      executionTime: 8,
      action: { p, m in
        let (_, _, _, PC, _, _) = p.tuple()
        
        m.pushWord(stackPointer: &p.SP, value: PC + 2)
        
        let offset = m.readByte(PC + 1)
        p.PC = (PC + 2).addingSigned(offset)
      }
    ),
  ]
}
