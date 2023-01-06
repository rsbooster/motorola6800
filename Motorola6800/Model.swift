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
  }
  
  enum Mnemonic {
    case ABA
    case LDAA
    case LDAB
    case WAI
  }
  
  let opCode: UInt8
  let mnemonic: Mnemonic
  let addressingMode: AddressingMode
  let executionTime: UInt8
  let action: (inout Processor, inout Memory) -> Void
}

typealias Memory = [UInt8]
