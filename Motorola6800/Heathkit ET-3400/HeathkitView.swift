import SwiftUI

struct HeathkitView: View {
  @Environment(\.scenePhase) var scenePhase
  
  private let keyboard: Keyboard
  private let displayAdapter: OutputAdapter<Display>
  private let terminal: Terminal
  private let casette: Casette
  private let execution: Execution
  private let sendDebouncer: Debouncer<String>
  private let hasExternal: Bool
  
  @State
  var trainerVisible = true
  @State
  var receiveText: String = ""
  @State
  var display: Display = .filled
  @State
  var frequency: UInt64 = 0
  
  init(
    terminalBaseAddress: UInt16 = 0x1000,
    roms: [Rom],
    external: [Rom] = []
  ) {
    self.keyboard = Keyboard()
    self.displayAdapter = OutputAdapter()
    self.terminal = Terminal(
      address: terminalBaseAddress
    )
    self.casette = Casette(
      address: terminalBaseAddress + 2
    )
    let inputDevices: [InputDevice] = [
      keyboard,
      terminal,
      casette
    ] + roms
    let outputDevices: [OutputDevice] = [
      displayAdapter,
      terminal,
      casette
    ]
    let memory = Memory(
      ram: Samples.decimalCounter,
      inputDevices: inputDevices,
      outputDevices: outputDevices,
      externalDevices: external
    )
    self.execution = Execution(
      memory: memory
    )
    self.sendDebouncer = Debouncer(action: terminal.send)
    self.hasExternal = !external.isEmpty
  }
  
  var body: some View {
    VStack(spacing: 30) {
      Button(trainerVisible ? "Trainer" : "Terminal") {
        trainerVisible.toggle()
      }.frame(maxWidth: .infinity, alignment: .trailing)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20))
      
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
          .font(.system(size: 11).monospaced())
          .padding(10)
        HStack {
          KeyboardHandler {
            terminal.send($0)
          }
          Button("Sample") {
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
          }
          if hasExternal {
            Button("Load External") {
              execution.loadExternalMemory()
            }
          }
          Button("Rec") {
            casette.record()
          }
          Button("Stop") {
            casette.stop()
          }
          Button("Play") {
            casette.play()
          }
        }.padding(defaultPadding)
        HStack {
          Button("^@") {
            terminal.send("\u{00}")
          }
          Button("ESC") {
            terminal.send("\u{1B}")
          }
          Button("CR") {
            terminal.send("\r")
          }
          Button("^A") {
            terminal.send("\u{01}")
          }
          Button("^B") {
            terminal.send("\u{02}")
          }
          Button("^C") {
            terminal.send("\u{03}")
          }
          Button("^H") {
            terminal.send("\u{08}")
          }
          Button("^P") {
            terminal.send("\u{10}")
          }
          Button("^S") {
            terminal.send("\u{13}")
          }
          Button("^T") {
            terminal.send("\u{14}")
          }
          Button("^X") {
            terminal.send("\u{18}")
          }
        }.padding(defaultPadding)
      }
    }
    .onChange(of: scenePhase) { phase in
      switch phase {
      case .active:
        displayAdapter.adaptee = $display
        terminal.onReceive = {
          receiveText = receiveTransform(text: receiveText, symbol: $0)
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

extension Rom {
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
    HeathkitView(
      roms: [Rom(file: "et3400rom", baseAddress: 0xFC00)]
    )
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

private func receiveTransform(text: String, symbol: String) -> String {
  if unsupportedSymbols.contains(symbol) {
    return text
  }
  if symbol.isNewline && text.last?.isNewline == true {
    return text
  }
  return (text + symbol).takeLastLines(20)
}

private func sendTransform(_ string: String) -> String {
  if string == "\u{201C}" {
    return "\""
  }
  return string.uppercased()
}

private let unsupportedSymbols: Set<String> = [
  "\u{00}",
  "\u{7F}",
]

private let defaultPadding = EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20)
