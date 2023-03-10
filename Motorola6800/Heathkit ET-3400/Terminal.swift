import Foundation

final class Terminal {
  private let uart: UART
  private let asciiHalfOnly: Bool
  
  var onReceive: ((String) -> Void)? {
    didSet {
      uart.onReceive = { [unowned self] byte in
        let mask: UInt8 = asciiHalfOnly ? 0x7F : 0xFF
        let value = String(bytes: [byte & mask], encoding: .ascii)!
        onReceive?(value)
      }
    }
  }
  
  init(
    address: UInt16,
    baudRate: UART.BaudRate = .high,
    cpuFrequency: UInt = 1_000_000,
    asciiHalfOnly: Bool = true
  ) {
    self.uart = UART(
      address: address,
      baudRate: baudRate,
      cpuFrequency: cpuFrequency
    )
    self.asciiHalfOnly = asciiHalfOnly
  }
  
  func send(_ string: String) {
    for byte in string.data(using: .ascii)! {
      uart.sendByte(byte)
    }
  }
}

extension Terminal: OutputDevice {
  var addressRange: ClosedRange<UInt16> {
    uart.addressRange
  }
  
  func writeByte(address: UInt16, value: UInt8) {
    uart.writeByte(address: address, value: value)
  }
  
  func tick() {
    uart.tick()
  }
}

extension Terminal: InputDevice {
  func readByte(address: UInt16) -> UInt8 {
    uart.readByte(address: address)
  }
}
