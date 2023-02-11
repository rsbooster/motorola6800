import SwiftUI

struct HeathkitView: View {
  @Environment(\.scenePhase) var scenePhase
  
  private let keyboard: Keyboard
  private let displayAdapter: DisplayAdapter
  private let terminal: Terminal
  private let execution: Execution
  
  @State
  var display: Display = .filled
  
  @State
  var frequency: UInt64 = 0
  
  init() {
    self.keyboard = Keyboard()
    self.displayAdapter = DisplayAdapter()
    self.terminal = Terminal()
    let memory = Memory(
      ram: Samples.terminalUsage,
      inputDevices: [keyboard, rom],
      outputDevices: [displayAdapter, terminal]
    )
    self.execution = Execution(
      memory: memory
    )
  }
  
  var body: some View {
    VStack(spacing: 30) {
      DisplayView(display: display)
        .frame(maxHeight: .infinity, alignment: .bottom)
      KeyboardView(keyboard: keyboard, reset: { execution.reset() })
        .frame(maxHeight: .infinity, alignment: .bottom)
      Text("CPS: \(frequency)")
        .font(.footnote)
        .monospacedDigit()
        .foregroundColor(.gray)
        .frame(maxWidth: .infinity, maxHeight: 30, alignment: .bottomTrailing)
        .padding(10)
    }
    .onChange(of: scenePhase) { phase in
      switch phase {
      case .active:
        displayAdapter.adaptee = $display
        execution.run(updateFrequency: { frequency = $0 })
      case .inactive, .background:
        execution.stop()
      default:
        break
      }
    }
  }
}

private let rom: Rom = {
  let url = Bundle.main.url(forResource: "et3400rom", withExtension: "bin")!
  let data = try! Data(contentsOf: url)
  return Rom(baseAddress: 0xFC00, data: data)
}()

private class DisplayAdapter: OutputDevice {
  var adaptee: Binding<Display> = .constant(.filled)
  
  var addressRange: ClosedRange<UInt16> {
    adaptee.wrappedValue.addressRange
  }
  
  func writeByte(address: UInt16, value: UInt8) {
    adaptee.wrappedValue.writeByte(address: address, value: value)
  }
}

struct HeathkitView_Previews: PreviewProvider {
  static var previews: some View {
    HeathkitView()
  }
}
