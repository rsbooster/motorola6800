import Foundation

extension InstructionSet {
  static let DAA = [
    Instruction(
      opCode: 0x19,
      mnemonic: .DAA,
      addressingMode: .inherent,
      executionTime: 2,
      action: { p, _ in
        let (A, B, X, PC, SP, CC) = p.tuple()
        
        let upperHalf = (A & 0xF0) >> 4
        let lowerHalf = A & 0x0F
        
        let addition: UInt8
        let carry: Bool
        
        switch (CC.C, upperHalf, CC.H, lowerHalf) {
        case (false, 0x0...0x9, false, 0x0...0x9):
          addition = 0x0
          carry = false
        case (false, 0x0...0x8, false, 0xA...0xF):
          addition = 0x6
          carry = false
        case (false, 0x0...0x9, true, 0x0...0x3):
          addition = 0x6
          carry = false
        case (false, 0xA...0xF, false, 0x0...0x9):
          addition = 0x60
          carry = true
        case (false, 0x9...0xF, false, 0xA...0xF):
          addition = 0x66
          carry = true
        case (false, 0xA...0xF, true, 0x0...0x3):
          addition = 0x66
          carry = true
        case (true, 0x0...0x2, false, 0x0...0x9):
          addition = 0x60
          carry = true
        case (true, 0x0...0x2, false, 0xA...0xF):
          addition = 0x66
          carry = true
        case (true, 0x0...0x3, true, 0x0...0x3):
          addition = 0x66
          carry = true
        default:
          fatalError()
        }
        
        let R = A &+ addition
        
        p.CC.N = R[7]
        p.CC.Z = R == 0
        p.CC.C = carry
        
        p.A = R
        p.PC += 1
      }
    ),
  ]
}
