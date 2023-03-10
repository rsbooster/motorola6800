import Foundation

final class Casette {
  private enum State: Equatable {
    case stopped
    case playing(readPosition: Int, tick: UInt)
    case recording
  }
  
  private let address: UInt16
  private let cellDuration: UInt
  
  private var state: State = .stopped
  private var buffer: [Bool] = []
  
  init(
    address: UInt16,
    cpuFrequency: UInt = 1_000_000
  ) {
    self.address = address
    self.cellDuration = cpuFrequency / baudRate / cellPerBit * cellParts
  }
  
  func record() {
    state = .recording
  }
  
  func stop() {
    if state == .recording {
      buffer.save()
    }
    state = .stopped
  }
  
  func play() {
    if buffer.isEmpty {
      buffer = .load()
    }
    state = .playing(readPosition: 0, tick: 0)
  }
}

extension Casette: OutputDevice {
  var addressRange: ClosedRange<UInt16> {
    address...address
  }
  
  func writeByte(address: UInt16, value: UInt8) {
    guard state == .recording else {
      return
    }
    buffer.append(value[0])
  }
  
  func tick() {
    switch state {
    case let .playing(readPosition, tick):
      if tick == cellDuration {
        state = .playing(readPosition: readPosition + 1, tick: 0)
      } else {
        state = .playing(readPosition: readPosition, tick: tick + 1)
      }
    case .recording, .stopped:
      break
    }
  }
}

extension Casette: InputDevice {
  func readByte(address: UInt16) -> UInt8 {
    switch state {
    case let .playing(readPosition, tick):
      return buffer
        .cell(at: readPosition)
        .signal(for: tick) ? 0xFF : 0x7F
    case .recording, .stopped:
      return 0xFF
    }
  }
}

private extension Array where Element: Codable {
  static func load() -> Array {
    let decoder = JSONDecoder()
    guard let data = try? Data(contentsOf: fileURL),
          let result = try? decoder.decode(self, from: data) else {
      return []
    }
    return result
  }
  
  func save() {
    let encoder = JSONEncoder()
    let data = try! encoder.encode(self)
    try! data.write(to: fileURL)
  }
}

private enum Cell {
  case high
  case low
  
  func signal(for tick: UInt) -> Bool {
    switch (self, tick) {
    case
      (.high, 416...624),
      (.low, 0...650):
      return true
    case (.high, _), (.low, _):
      return false
    }
  }
}

private extension Array where Element == Bool {
  func cell(at index: Int) -> Cell {
    let value = element(at: index * 2) && element(at: index * 2 + 1)
    return value ? .high : .low
  }
  
  private func element(at index: Int) -> Bool {
    if index < count {
      return self[index]
    } else {
      return true
    }
  }
}

private let baudRate: UInt = 300
private let cellPerBit: UInt = 8
private let cellParts: UInt = 2

private let fileURL = FileManager
  .default
  .urls(for: .documentDirectory, in: .userDomainMask)
  .first!
  .appending(component: "casette.json")
