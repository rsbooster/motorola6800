import SwiftUI

struct HeathkitView: View {
  private let keyboard: Keyboard
  private let displayAdapter: DisplayAdapter
  private let execution: Execution
  
  @State
  var display: Display = .filled
  
  @State
  var frequency: UInt64 = 0
  
  init() {
    self.keyboard = Keyboard()
    self.displayAdapter = DisplayAdapter()
    let memory = Memory(
      ram: Samples.branchCalculator,
      rom: rom,
      inputDevices: [keyboard],
      outputDevices: [displayAdapter]
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
      Text("\(frequency)")
        .font(.footnote)
        .frame(maxWidth: .infinity, maxHeight: 200, alignment: .bottomTrailing)
        .padding(10)
    }
    .onAppear {
      displayAdapter.adaptee = $display
      execution.run(updateFrequency: { frequency = $0 })
    }
  }
}

private let rom: Data = {
  let url = Bundle.main.url(forResource: "et3400rom", withExtension: "bin")!
  return try! Data(contentsOf: url)
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
