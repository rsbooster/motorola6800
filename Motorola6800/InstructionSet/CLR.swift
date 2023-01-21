import Foundation

extension InstructionSet {
  static let CLR = [
    Instruction(
      opCode: 0x4F,
      mnemonic: .CLRA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.A = 0
        p.CC.update()
        
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x5F,
      mnemonic: .CLRB,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        p.B = 0
        p.CC.update()
        
        p.PC += 1
      }
    ),
    Instruction(
      opCode: 0x7F,
      mnemonic: .CLR,
      addressingMode: .extended,
      executionTime: 6,
      action: { p, m in
        let (_, _, _, PC, _, _) = p.tuple()
        
        let (_, address) = m.readOperandExtended8(PC + 1)
        m.writeByte(address: address, value: 0)
        p.CC.update()
        
        p.PC += 3
      }
    ),
    Instruction(
      opCode: 0x6F,
      mnemonic: .CLR,
      addressingMode: .indexed,
      executionTime: 7,
      action: { p, m in
        let (_, _, X, PC, _, _) = p.tuple()
        
        let (_, address) = m.readOperandIndexed8(PC + 1, X: X)
        m.writeByte(address: address, value: 0)
        p.CC.update()
        
        p.PC += 2
      }
    )
  ]
}

private extension Processor.ConditionCodes {
  mutating func update() {
    N = false
    Z = true
    V = false
    C = false
  }
}
