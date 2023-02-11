protocol Device {
  func tick()
}

extension Device {
  func tick() {}
}

protocol InputDevice: Device {
  var addressRange: ClosedRange<UInt16> { get }
  
  func readByte(address: UInt16) -> UInt8
}

protocol OutputDevice: Device {
  var addressRange: ClosedRange<UInt16> { get }
  
  mutating func writeByte(address: UInt16, value: UInt8)
}
