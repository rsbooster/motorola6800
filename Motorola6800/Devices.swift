protocol InputDevice {
  var addressRange: ClosedRange<UInt16> { get }
  
  func readByte(address: UInt16) -> UInt8
}

protocol OutputDevice {
  var startAddress: UInt16 { get }
  var size: UInt16 { get }
  
  mutating func write(_ data: [UInt8])
}
