import Foundation

struct Processor {
  struct ConditionCodes {
    var H: Bool
    var I: Bool
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
    case ADCA
    case ADCB
    case ADDA
    case ADDB
    case ANDA
    case ANDB
    case ASL
    case ASLA
    case ASLB
    case ASR
    case ASRA
    case ASRB
    case BCC
    case BCS
    case BEQ
    case BGE
    case BGT
    case BHI
    case BITA
    case BITB
    case BLE
    case BLS
    case BLT
    case BMI
    case BNE
    case BPL
    case BRA
    case BSR
    case BVC
    case BVS
    case CBA
    case CLC
    case CLI
    case CLR
    case CLRA
    case CLRB
    case CLV
    case CMPA
    case CMPB
    case COM
    case COMA
    case COMB
    case CPX
    case DAA
    case DEC
    case DECA
    case DECB
    case DES
    case DEX
    case EORA
    case EORB
    case INC
    case INCA
    case INCB
    case INS
    case INX
    case JMP
    case JSR
    case LDAA
    case LDAB
    case LDS
    case LDX
    case LSRA
    case LSRB
    case LSR
    case NEGA
    case NEGB
    case NEG
    case NOP
    case RTS
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
  
  mutating func pullByte(stackPointer: inout UInt16) -> UInt8 {
    stackPointer += 1
    return readByte(stackPointer)
  }
  
  mutating func pullWord(stackPointer: inout UInt16) -> UInt16 {
    stackPointer += 2
    return readWord(stackPointer)
  }
}

extension Memory {
  func readOperandDirect(_ address: UInt16) -> UInt8 {
    readOperandDirect8(address).value
  }
  
  func readOperandDirect8(_ address: UInt16) -> (value: UInt8, address: UInt16) {
    let ref = readByte(address)
    let value = readByte(UInt16(ref))
    return (value, UInt16(ref))
  }
  
  func readOperandDirect(_ address: UInt16) -> UInt16 {
    readOperandDirect16(address).value
  }
  
  func readOperandDirect16(_ address: UInt16) -> (value: UInt16, address: UInt16) {
    let ref = readByte(address)
    let value = readWord(UInt16(ref))
    return (value, UInt16(ref))
  }
  
  func readOperandExtended(_ address: UInt16) -> UInt8 {
    readOperandExtended8(address).value
  }
  
  func readOperandExtended8(_ address: UInt16) -> (value: UInt8, address: UInt16) {
    let ref = readWord(address)
    let value = readByte(ref)
    return (value, ref)
  }
  
  func readOperandExtended(_ address: UInt16) -> UInt16 {
    readOperandExtended16(address).value
  }
  
  func readOperandExtended16(_ address: UInt16) -> (value: UInt16, address: UInt16) {
    let ref = readWord(address)
    let value = readWord(ref)
    return (value, ref)
  }
  
  func readOperandIndexed(_ address: UInt16, X: UInt16) -> UInt8 {
    readOperandIndexed8(address, X: X).value
  }
  
  func readOperandIndexed8(_ address: UInt16, X: UInt16) -> (value: UInt8, address: UInt16) {
    let offset = readByte(address)
    let ref = X + UInt16(offset)
    let value = readByte(ref)
    return (value, ref)
  }
  
  func readOperandIndexed(_ address: UInt16, X: UInt16) -> UInt16 {
    readOperandIndexed16(address, X: X).value
  }
  
  func readOperandIndexed16(_ address: UInt16, X: UInt16) -> (value: UInt16, address: UInt16) {
    let offset = readByte(address)
    let ref = X + UInt16(offset)
    let value = readWord(ref)
    return (value, ref)
  }
}

extension Processor: CustomStringConvertible {
  var description: String {
    String(
      format: "A:%02X B:%02X X:%04X PC:%04X SP:%04X  H:%X I:%X N:%X Z:%X V:%X C:%X",
      A, B, X, PC, SP,
      CC.H, CC.I, CC.N, CC.Z, CC.V, CC.C
    )
  }
}

extension Processor.ConditionCodes {
  var asByte: UInt8 {
    (H ? 0x20 : 0) |
    (I ? 0x10 : 0) |
    (N ? 0x8 : 0) |
    (Z ? 0x4 : 0) |
    (V ? 0x2 : 0) |
    (C ? 0x1 : 0)
  }
}
