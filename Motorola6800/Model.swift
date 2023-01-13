import Foundation

struct Processor {
  struct ConditionCodes {
    var H: Bool
    var N: Bool
    var Z: Bool
    var V: Bool
    var C: Bool
  }
  
  var A: UInt8
  var B: UInt8
  var X: UInt16
  
  var PC: UInt16
  var SP: UInt16
  
  var CC: ConditionCodes
}

struct Instruction {
  enum AddressingMode {
    case immediate
    case direct
    case indexed
    case extended
    case inherent
    case relative
  }
  
  enum Mnemonic {
    case ABA
    case BCC
    case BRA
    case COM
    case COMA
    case COMB
    case DAA
    case JMP
    case LDAA
    case LDAB
    case LDS
    case LDX
    case NEGA
    case NEGB
    case NEG
    case NOP
    case WAI
  }
  
  let opCode: UInt8
  let mnemonic: Mnemonic
  let addressingMode: AddressingMode
  let executionTime: UInt8
  let action: (inout Processor, inout Memory) -> Void
}

struct Memory {
  private var content: [UInt8]
  private let romSize: UInt16
  
  init(
    content: [UInt8],
    romSize: UInt16
  ) {
    self.content = content
    self.romSize = romSize
  }
  
  func readByte(_ address: UInt16) -> UInt8 {
    content[Int(address)]
  }
  
  func readWord(_ address: UInt16) -> UInt16 {
    UInt16(readByte(address)) << 8 + UInt16(readByte(address + 1))
  }
  
  mutating func writeByte(address: UInt16, value: UInt8) {
    guard address < (0xFFFF - romSize) else {
      return
    }
    content[Int(address)] = value
  }
  
  mutating func pushByte(stackPointer: inout UInt16, value: UInt8) {
    writeByte(address: stackPointer, value: value)
    stackPointer -= 1
  }
  
  mutating func pushWord(stackPointer: inout UInt16, value: UInt16) {
    writeByte(address: stackPointer, value: value.lower)
    writeByte(address: stackPointer - 1, value: value.upper)
    stackPointer -= 2
  }
}

extension Processor: CustomStringConvertible {
  var description: String {
    String(
      format: "A:%02X B:%02X X:%04X PC:%04X SP:%04X  H:%X N:%X Z:%X V:%X C:%X",
      A, B, X, PC, SP,
      CC.H, CC.N, CC.Z, CC.V, CC.C
    )
  }
}

extension Processor.ConditionCodes {
  var asByte: UInt8 {
    (H ? 0x1 : 0) |
    (N ? 0x2 : 0) |
    (Z ? 0x4 : 0) |
    (V ? 0x8 : 0) |
    (C ? 0x10 : 0)
  }
}
