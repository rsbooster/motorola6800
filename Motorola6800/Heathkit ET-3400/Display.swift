struct Display {
  struct Indicator {
    var a: Bool
    var b: Bool
    var c: Bool
    var d: Bool
    var e: Bool
    var f: Bool
    var g: Bool
    var DP: Bool
  }
  
  var H: Indicator
  var I: Indicator
  var N: Indicator
  var Z: Indicator
  var V: Indicator
  var C: Indicator
}

extension Display: OutputDevice {
  var addressRange: ClosedRange<UInt16> {
    0xC110...0xC16F
  }
  
  mutating func writeByte(address: UInt16, value: UInt8) {
    let indicatorAddress = address & 0xFFF0
    let segmentAddress = address & 0x0007
    
    switch indicatorAddress {
    case 0xC110:
      C.writeSegment(address: segmentAddress, value: value)
    case 0xC120:
      V.writeSegment(address: segmentAddress, value: value)
    case 0xC130:
      Z.writeSegment(address: segmentAddress, value: value)
    case 0xC140:
      N.writeSegment(address: segmentAddress, value: value)
    case 0xC150:
      I.writeSegment(address: segmentAddress, value: value)
    case 0xC160:
      H.writeSegment(address: segmentAddress, value: value)
    default:
      break
    }
  }
}

private extension Display.Indicator {
  mutating func writeSegment(address: UInt16, value: UInt8) {
    switch address {
    case 0x7:
      DP = value[0]
    case 0x6:
      a = value[0]
    case 0x5:
      b = value[0]
    case 0x4:
      c = value[0]
    case 0x3:
      d = value[0]
    case 0x2:
      e = value[0]
    case 0x1:
      f = value[0]
    case 0x0:
      g = value[0]
    default:
      fatalError()
    }
  }
}

extension Display {
  static var filled: Self {
    Display(
      H: .filled,
      I: .filled,
      N: .filled,
      Z: .filled,
      V: .filled,
      C: .filled
    )
  }
}

private extension Display.Indicator {
  static var filled: Self {
    Display.Indicator(
      a: true,
      b: true,
      c: true,
      d: true,
      e: true,
      f: true,
      g: true,
      DP: true
    )
  }
}
