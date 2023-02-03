final class Keyboard {
  var key_F = false
  var key_E = false
  var key_D = false
  
  var key_C = false
  var key_B = false
  var key_A = false
  
  var key_9 = false
  var key_8 = false
  var key_7 = false
  
  var key_6 = false
  var key_5 = false
  var key_4 = false
  
  var key_3 = false
  var key_2 = false
  var key_1 = false
  
  var key_0 = false
  var key_RESET = false
}

extension Keyboard: InputDevice {
  var addressRange: ClosedRange<UInt16> {
    0xC000...0xC00E
  }
  
  func readByte(address: UInt16) -> UInt8 {
    switch address {
    case 0xC003:
      return 0xFF
        & (key_3 ? 0xEF : 0xFF)
        & (key_6 ? 0xF7 : 0xFF)
        & (key_9 ? 0xFB : 0xFF)
        & (key_C ? 0xFD : 0xFF)
        & (key_F ? 0xFE : 0xFF)
    case 0xC005:
      return 0xFF
        & (key_2 ? 0xEF : 0xFF)
        & (key_5 ? 0xF7 : 0xFF)
        & (key_8 ? 0xFB : 0xFF)
        & (key_B ? 0xFD : 0xFF)
        & (key_E ? 0xFE : 0xFF)
    case 0xC006:
      return 0xFF
        & (key_0 ? 0xDF : 0xFF)
        & (key_1 ? 0xEF : 0xFF)
        & (key_4 ? 0xF7 : 0xFF)
        & (key_7 ? 0xFB : 0xFF)
        & (key_A ? 0xFD : 0xFF)
        & (key_D ? 0xFE : 0xFF)
    default:
      return 0xFF
    }
  }
}
