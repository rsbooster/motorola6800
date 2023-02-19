import SwiftUI

struct HeathkitView: View {
  @Environment(\.scenePhase) var scenePhase
  
  private let keyboard: Keyboard
  private let displayAdapter: OutputAdapter<Display>
  private let terminal: Terminal
  private let execution: Execution
  private let sendDebouncer: Debouncer<String>
  
  @State
  var trainerVisible = true
  @State
  var receiveText: String = ""
  @State
  var display: Display = .filled
  @State
  var frequency: UInt64 = 0
  
  init() {
    self.keyboard = Keyboard()
    self.displayAdapter = OutputAdapter()
    self.terminal = Terminal(
      address: 0x1000
    )
    let inputDevices: [InputDevice] = [
      keyboard,
      terminal,
      Rom(file: "eta_monitor", baseAddress: 0x1400),
      Rom(file: "eta_basic", baseAddress: 0x1C00),
      Rom(file: "et3400rom", baseAddress: 0xFC00),
    ]
    let memory = Memory(
      ram: Samples.terminalUsage,
      inputDevices: inputDevices,
      outputDevices: [displayAdapter, terminal]
    )
    self.execution = Execution(
      memory: memory
    )
    self.sendDebouncer = Debouncer(action: terminal.send)
  }
  
  var body: some View {
    VStack(spacing: 30) {
      Button(trainerVisible ? "Trainer" : "Terminal") {
        trainerVisible.toggle()
      }.frame(maxWidth: .infinity, alignment: .trailing)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 50))
      
      if trainerVisible {
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
      } else {
        Text(
          receiveText
        ).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
          .lineLimit(11, reservesSpace: true)
          .padding(10)
        TextField(
          text: Binding(
            get: { "" },
            set: {
              sendDebouncer.apply(
                value: $0 == "" ? "\r" : $0
              )
            }
          )
        ) {
          Text("Keyboard")
        }.padding(10)
        Button("Send sample") {
          [
            "G 1C00\r",
            "100 LET I=0\r",
            "200 PRINT \"HEATH TINY BASIC\"\r",
            "300 I=I+1\r",
            "400 IF I<5 GOTO 200\r",
            "500 END\r",
            "RUN\r",
          ].forEach {
            terminal.send($0)
          }
        }.frame(maxWidth: .infinity, alignment: .leading)
          .padding(10)
      }
    }
    .onChange(of: scenePhase) { phase in
      switch phase {
      case .active:
        displayAdapter.adaptee = $display
        terminal.onReceive = { symbol in
          guard symbol != "\0" else {
            return
          }
          receiveText = (receiveText + symbol).takeLastLines(10)
        }
        execution.run(updateFrequency: { frequency = $0 })
      case .inactive, .background:
        execution.stop()
      default:
        break
      }
    }
  }
}

private extension Rom {
  init(file: String, baseAddress: UInt16) {
    let url = Bundle.main.url(forResource: file, withExtension: "bin")!
    let data = try! Data(contentsOf: url)
    self.init(baseAddress: baseAddress, data: data)
  }
}

private class OutputAdapter<T: OutputDevice>: OutputDevice {
  var adaptee: Binding<T>!
  
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

private final class Debouncer<T: Equatable> {
  let action: (T) -> Void
  
  var lastValue: T?
  
  init(action: @escaping (T) -> Void) {
    self.action = action
  }
  
  func apply(value: T) {
    guard lastValue != value else {
      lastValue = nil
      return
    }
    action(value)
    lastValue = value
  }
}
