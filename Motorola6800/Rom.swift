import Foundation

struct Rom: InputDevice {
  let addressRange: ClosedRange<UInt16>
  private let data: Data
  
  init(
    baseAddress: UInt16,
    data: Data
  ) {
    let upperBound = baseAddress &- 1 &+ UInt16(data.count)
    self.addressRange = baseAddress...upperBound
    self.data = data
  }
  
  func readByte(address: UInt16) -> UInt8 {
    data[Int(address - addressRange.lowerBound)]
  }
}
