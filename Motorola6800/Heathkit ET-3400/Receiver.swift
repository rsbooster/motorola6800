import Foundation

final class Receiver {
  private enum State {
    case idle
    case receive(accumulator: [Bool], waitCycles: UInt)
  }
  
  private let delay: UInt
  private let receiveMask: UInt8
  
  private var state: State = .idle
  
  var latch = true
  var onReceive: ((String) -> Void)?
  
  init(
    delay: UInt,
    receiveMask: UInt8
  ) {
    self.delay = delay
    self.receiveMask = receiveMask
  }
  
  func tick() {
    switch (state, latch) {
    case (.idle, false):
      state = .receive(accumulator: [], waitCycles: delay + delay / 10)
    case (.idle, true):
      break
    case let (.receive(accumulator, 0), latch):
      if accumulator.count == 8 {
        if latch {
          let symbol = String(bytes: [accumulator.asByte & receiveMask], encoding: .ascii)!
          onReceive?(symbol)
        }
        state = .idle
      } else {
        state = .receive(accumulator: accumulator + [latch], waitCycles: delay)
      }
    case let (.receive(accumulator, waitCycles), _):
      state = .receive(accumulator: accumulator, waitCycles: waitCycles - 1)
    }
  }
}

extension Array where Element == Bool {
  var asByte: UInt8 {
    UInt8(0)
      | (self[0] ? 0x1 : 0x0)
      | (self[1] ? 0x2 : 0x0)
      | (self[2] ? 0x4 : 0x0)
      | (self[3] ? 0x8 : 0x0)
      | (self[4] ? 0x10 : 0x0)
      | (self[5] ? 0x20 : 0x0)
      | (self[6] ? 0x40 : 0x0)
      | (self[7] ? 0x80 : 0x0)
  }
}
