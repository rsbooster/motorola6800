final class Terminal {
  private enum State {
    case idle
    case receive(accumulator: [Bool], waitCycles: UInt)
    
  }
  private var state: State = .idle
  private let delay: UInt
  private let bitNumber: UInt8
  
  private var latch: Bool = true
  var text: String = ""
  
  init(
    speed: UInt = 80,
    cpuFrequency: UInt = 1_000_000,
    bitNumber: UInt8 = 0
  ) {
    self.delay = cpuFrequency / speed
    self.bitNumber = bitNumber
  }
}

extension Terminal: OutputDevice {
  var addressRange: ClosedRange<UInt16> {
    0x1000...0x1000
  }
  
  func writeByte(address: UInt16, value: UInt8) {
    latch = value[bitNumber]
  }
  
  func tick() {
    switch state {
    case .idle:
      if latch == false {
        state = .receive(accumulator: [], waitCycles: delay + delay / 3)
      }
    case let .receive(accumulator, waitCycles):
      if waitCycles == 0 {
        if accumulator.count == 8 {
          if latch {
            let symbol = String(bytes: [accumulator.asByte], encoding: .ascii)!
            text += symbol
            print("###\(text)")
          }
          state = .idle
        } else {
          state = .receive(accumulator: accumulator + [latch], waitCycles: delay)
        }
      } else {
        state = .receive(accumulator: accumulator, waitCycles: waitCycles - 1)
      }
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
