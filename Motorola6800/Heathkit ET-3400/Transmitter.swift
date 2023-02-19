import Foundation

final class Transmitter {
  private let delay: UInt
  private let crDelay: UInt
  
  private var waitCycles: UInt = 0
  private var sendBuffer: [(value: Bool, delay: UInt)] = []
  
  var latch: Bool = true
  
  init(
    delay: UInt,
    crDelay: UInt = 250_000
  ) {
    self.delay = delay
    self.crDelay = crDelay
  }
  
  func tick() {
    guard !sendBuffer.isEmpty else {
      return
    }
    if waitCycles == 0 {
      (latch, waitCycles) = sendBuffer.remove(at: 0)
    } else {
      waitCycles -= 1
    }
  }

  func sendByte(_ byte: UInt8) {
    appendRegular(false)
    appendRegular(byte[0])
    appendRegular(byte[1])
    appendRegular(byte[2])
    appendRegular(byte[3])
    appendRegular(byte[4])
    appendRegular(byte[5])
    appendRegular(byte[6])
    appendRegular(byte[7])
    appendRegular(true)
    appendRegular(true)
    appendRegular(true)
    
    if byte == 0x0D {
      appendDelay()
    }
  }
  
  private func appendRegular(_ value: Bool) {
    sendBuffer.append((value: value, delay: delay))
  }
  
  private func appendDelay() {
    sendBuffer.append((value: true, delay: crDelay))
  }
}
