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

typealias Memory = [UInt8]

extension Processor: CustomStringConvertible {
  var description: String {
    String(
      format: "A:%02X B:%02X X:%04X PC:%04X SP:%04X  H:%X N:%X Z:%X V:%X C:%X",
      A, B, X, PC, SP,
      CC.H, CC.N, CC.Z, CC.V, CC.C
    )
  }
}
