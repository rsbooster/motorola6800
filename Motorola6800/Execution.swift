import Foundation
import SwiftUI

final class Execution {
  private let instructionMap: [UInt8: Instruction]
  private var processor: Processor
  private var memory: Memory
  
  private var input: [Binding<InputDevice>] = []
  private var output: [Binding<OutputDevice>] = []
  
  private var logging = false
  private lazy var timer = Timer.scheduledTimer(
    withTimeInterval: 1e-6,
    repeats: true,
    block: { [weak self] _ in
      self?.step()
    }
  )
  
  convenience init(rom: Data) {
    let instructionMap = Dictionary(
      uniqueKeysWithValues: InstructionSet.all.map { ($0.opCode, $0 )}
    )
    let ram: [UInt8] = [
      0x86, 0x00,
      0x8B, 0x01,
      
      0x19,
      
      0xBD, 0xFC, 0xBC,
      0xBD, 0xFE, 0x20,

      0x7E, 0x00, 0x02,

      0x3E,
    ]
    
    self.init(
      instructionMap: instructionMap,
      memory: Memory(ram: ram, rom: rom)
    )
  }
  
  init(
    instructionMap: [UInt8: Instruction],
    memory: Memory
  ) {
    self.instructionMap = instructionMap
    self.memory = memory
    self.processor = Processor(
      A: 0,
      B: 0,
      X: 0,
      PC: 0,
      SP: 0,
      CC: .init(H: false, I: false, N: false, Z: false, V: false, C: false),
      emulated: .init(waitingForInterrupt: false)
    )
    reset()
  }
  
  func step() {
    if !processor.emulated.waitingForInterrupt {
      if logging {
        print(processor.description)
      }
      
      for device in input {
        for (index, byte) in device.wrappedValue.read().enumerated() {
          memory.writeByte(address: device.wrappedValue.startAddress + UInt16(index), value: byte)
        }
      }
      
      let opCode = memory.readByte(processor.PC)
      let instruction = instructionMap[opCode]!
      
      instruction.action(&processor, &memory)
      
      for device in output {
        var data = Array<UInt8>(
          repeating: 0,
          count: Int(device.wrappedValue.size)
        )
        for index in 0..<device.wrappedValue.size {
          data[Int(index)] = memory.readByte(device.wrappedValue.startAddress + index)
        }
        device.wrappedValue.write(data)
      }
    }
  }
  
  func run(
    input: [Binding<InputDevice>],
    output: [Binding<OutputDevice>]
  ) {
    self.input = input
    self.output = output
    RunLoop.main.add(timer, forMode: .common)
  }
  
  func reset() {
    processor.PC = memory.readWord(0xFFFE)
  }
  
  deinit {
    timer.invalidate()
  }
}
