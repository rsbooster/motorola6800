protocol InputDevice {
  var startAddress: UInt16 { get }
  
  func read() -> [UInt8]
}

protocol OutputDevice {
  var startAddress: UInt16 { get }
  var size: UInt16 { get }
  
  mutating func write(_ data: [UInt8])
}
