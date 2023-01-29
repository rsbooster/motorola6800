struct Keyboard {
  var key_F: Bool
  var key_E: Bool
  var key_D: Bool
  
  var key_C: Bool
  var key_B: Bool
  var key_A: Bool
  
  var key_9: Bool
  var key_8: Bool
  var key_7: Bool
  
  var key_6: Bool
  var key_5: Bool
  var key_4: Bool
  
  var key_3: Bool
  var key_2: Bool
  var key_1: Bool
  
  var key_0: Bool
  var key_RESET: Bool
}

extension Keyboard: InputDevice {
  var startAddress: UInt16 {
    0xC000
  }
  
  func read() -> [UInt8] {
    let column1: UInt8 = 0xFF
      & (key_0 ? 0xDF : 0xFF)
      & (key_1 ? 0xEF : 0xFF)
      & (key_4 ? 0xF7 : 0xFF)
      & (key_7 ? 0xFB : 0xFF)
      & (key_A ? 0xFD : 0xFF)
      & (key_D ? 0xFE : 0xFF)
    
    let column2: UInt8 = 0xFF
      & (key_2 ? 0xEF : 0xFF)
      & (key_5 ? 0xF7 : 0xFF)
      & (key_8 ? 0xFB : 0xFF)
      & (key_B ? 0xFD : 0xFF)
      & (key_E ? 0xFE : 0xFF)
    
    let column3: UInt8 = 0xFF
      & (key_3 ? 0xEF : 0xFF)
      & (key_6 ? 0xF7 : 0xFF)
      & (key_9 ? 0xFB : 0xFF)
      & (key_C ? 0xFD : 0xFF)
      & (key_F ? 0xFE : 0xFF)
    
    return [
      0x0,
      0x0,
      0x0,
      column3,
      0x0,
      column2,
      column1,
    ]
  }
}

extension Keyboard {
  static var empty: Self {
    Keyboard(
      key_F: false,
      key_E: false,
      key_D: false,
      key_C: false,
      key_B: false,
      key_A: false,
      key_9: false,
      key_8: false,
      key_7: false,
      key_6: false,
      key_5: false,
      key_4: false,
      key_3: false,
      key_2: false,
      key_1: false,
      key_0: false,
      key_RESET: false
    )
  }
}
