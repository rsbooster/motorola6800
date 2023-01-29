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
  var startAddress: UInt16 {
    0xC110
  }
  
  var size: UInt16 {
    0x5F
  }
  
  mutating func write(_ data: [UInt8]) {
    H = readIndicator(data, address: 0x50)
    I = readIndicator(data, address: 0x40)
    N = readIndicator(data, address: 0x30)
    Z = readIndicator(data, address: 0x20)
    V = readIndicator(data, address: 0x10)
    C = readIndicator(data, address: 0x0)
  }
}

private func readIndicator(
  _ data: [UInt8],
  address: Int
) -> Display.Indicator {
  Display.Indicator(
    a: data[address + 6][0],
    b: data[address + 5][0],
    c: data[address + 4][0],
    d: data[address + 3][0],
    e: data[address + 2][0],
    f: data[address + 1][0],
    g: data[address + 0][0],
    DP: data[address + 7][0]
  )
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
