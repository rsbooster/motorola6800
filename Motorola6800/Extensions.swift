import Foundation

extension Array where Element == UInt8 {
  func readByte(_ address: UInt16) -> UInt8 {
      self[Int(address)]
  }
  
  func readWord(_ address: UInt16) -> UInt16 {
    UInt16(readByte(address)) << 8 + UInt16(readByte(address + 1))
  }
}

extension UInt16 {
  func addingSigned(_ signed: UInt8) -> UInt16 {
    let negative = signed[7]
    
    if negative {
      let value = 0xFF - signed
      return self - UInt16(value)
    } else {
      return self + UInt16(signed)
    }
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

func isCarry(_ a: Bool, _ b: Bool, _ r: Bool) -> Bool {
  (a && b) || (b && !r) || (!r && a)
}

func isOverflow(_ a: Bool, _ b: Bool, _ r: Bool) -> Bool {
  (a && b && !r) || (!a && !b && r)
}

