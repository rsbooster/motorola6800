protocol InputDevice {
  var addressRange: ClosedRange<UInt16> { get }
  
  func readByte(address: UInt16) -> UInt8
}

protocol OutputDevice {
  var addressRange: ClosedRange<UInt16> { get }
  
  mutating func writeByte(address: UInt16, value: UInt8)
}
