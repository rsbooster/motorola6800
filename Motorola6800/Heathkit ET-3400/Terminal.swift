import Foundation

final class Terminal {
  enum BaudRate {
    case low
    case high
  }
  
  private let address: UInt16
  private let baudRate: BaudRate
  
  private let receiver: Receiver
  private let transmitter: Transmitter
  
  var onReceive: ((String) -> Void)? {
    get { receiver.onReceive }
    set { receiver.onReceive = newValue }
  }
  
  init(
    address: UInt16,
    baudRate: BaudRate = .high,
    cpuFrequency: UInt = 1_000_000,
    asciiHalfOnly: Bool = true
  ) {
    let delay = cpuFrequency / baudRate.speed
    
    self.address = address
    self.baudRate = baudRate
    self.receiver = Receiver(
      delay: delay,
      receiveMask: asciiHalfOnly ? 0x7F : 0xFF
    )
    self.transmitter = Transmitter(delay: delay)
  }
  
  func send(_ string: String) {
    for byte in string.data(using: .ascii)! {
      transmitter.sendByte(byte)
    }
  }
}

extension Terminal: OutputDevice {
  var addressRange: ClosedRange<UInt16> {
    address...address
  }
  
  func writeByte(address: UInt16, value: UInt8) {
    receiver.latch = value[0]
  }
  
  func tick() {
    receiver.tick()
    transmitter.tick()
  }
}

extension Terminal: InputDevice {
  func readByte(address: UInt16) -> UInt8 {
    (transmitter.latch ? 0x80 : 0x00)
    | baudRate.divider
  }
}

extension Terminal.BaudRate {
  var speed: UInt {
    switch self {
    case .low:
      return 110
    case .high:
      return 2400
    }
  }
  
  var divider: UInt8 {
    switch self {
    case .low:
      return 0
    case .high:
      return 0x04
    }
  }
}
