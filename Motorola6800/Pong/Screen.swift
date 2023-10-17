import Foundation

final class Screen: OutputDevice {
  struct Pixel: Hashable {
    let x: UInt8
    let y: UInt8
  }
  
  var addressRange: ClosedRange<UInt16> {
    0x2000...0x3FFF
  }
  
  private var buffer: Set<Pixel> = []
  
  var onUpdate: ((Set<Pixel>) -> Void)?
  
  func writeByte(address: UInt16, value: UInt8) {
    let offset = address - addressRange.lowerBound
    let line = UInt8(offset / 0x20)
    let position = UInt8(offset % 0x20) * 8

    for i in bitRange {
      let pixel = Pixel(x: position + i, y: line)
      if value[i] {
        buffer.insert(pixel)
      } else {
        buffer.remove(pixel)
      }
    }
    
    onUpdate?(buffer)
  }
}

private let bitRange: ClosedRange<UInt8> = 0...7
