import Foundation

extension UInt16 {
  func addingSigned(_ signed: UInt8) -> UInt16 {
    let negative = signed[7]
    let mask: UInt16 = negative ? 0xFF00 : 0x0
    let large = UInt16(signed) | mask
    let (result, _) = self.addingReportingOverflow(large)
    return result
  }
  
  var upper: UInt8 {
    UInt8((self & 0xFF00) >> 8)
  }
  
  var lower: UInt8 {
    UInt8(self & 0x00FF)
  }
}

extension Processor {
  func tuple() -> (A: UInt8, B: UInt8, X: UInt16, PC: UInt16, SP: UInt16, CC: ConditionCodes) {
    (A: self.A, B: self.B, X: self.X, PC: self.PC, SP: self.SP, CC: self.CC)
  }
}

extension BinaryInteger {
  subscript (index: UInt8) -> Bool {
    self & (0x1 << index) != 0
  }
}

extension Bool {  
  var asInt: UInt8 {
    self ? 1 : 0
  }
}

func isCarry(_ a: Bool, _ b: Bool, _ r: Bool) -> Bool {
  (a && b) || (b && !r) || (!r && a)
}

func isOverflow(_ a: Bool, _ b: Bool, _ r: Bool) -> Bool {
  (a && b && !r) || (!a && !b && r)
}

