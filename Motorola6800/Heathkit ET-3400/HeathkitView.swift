import SwiftUI

struct HeathkitView: View {
  private let execution = Execution(rom: rom)
  
  @State
  var display: Display = .filled
  @State
  var keyboard: Keyboard = .empty
  
  var body: some View {
    VStack(spacing: 30) {
      DisplayView(display: display)
      KeyboardView(keyboard: $keyboard, reset: { execution.reset() })
    }
    .onAppear {
      let input = Binding<InputDevice>(
        get: { keyboard },
        set: { keyboard = $0 as! Keyboard }
      )
      let output = Binding<OutputDevice>(
        get: { display },
        set: { display = $0 as! Display }
      )
      execution.run(
        input: [input],
        output: [output]
      )
    }
  }
}

struct KeyboardView: View {
  @Binding
  var keyboard: Keyboard
  let reset: () -> Void
  
  var body: some View {
    VStack {
      HStack {
        KeyboardButton(title: "DO", subtitle: "D", value: $keyboard.key_D)
        KeyboardButton(title: "EXAM", subtitle: "E", value: $keyboard.key_E)
        KeyboardButton(title: "FWD", subtitle: "F", value: $keyboard.key_F)
      }
      HStack {
        KeyboardButton(title: "AUTO", subtitle: "A", value: $keyboard.key_A)
        KeyboardButton(title: "BACK", subtitle: "B", value: $keyboard.key_B)
        KeyboardButton(title: "CHAN", subtitle: "C", value: $keyboard.key_C)
      }
      HStack {
        KeyboardButton(title: "RTI", subtitle: "7", value: $keyboard.key_7)
        KeyboardButton(title: "SS", subtitle: "8", value: $keyboard.key_8)
        KeyboardButton(title: "BR", subtitle: "9", value: $keyboard.key_9)
      }
      HStack {
        KeyboardButton(title: "INDEX", subtitle: "4", value: $keyboard.key_4)
        KeyboardButton(title: "CC", subtitle: "5", value: $keyboard.key_5)
        KeyboardButton(title: "SP", subtitle: "6", value: $keyboard.key_6)
      }
      HStack {
        KeyboardButton(title: "ACCA", subtitle: "1", value: $keyboard.key_1)
        KeyboardButton(title: "ACCB", subtitle: "2", value: $keyboard.key_2)
        KeyboardButton(title: "PC", subtitle: "3", value: $keyboard.key_3)
      }
      HStack {
        KeyboardButton(title: "", subtitle: "0", value: $keyboard.key_0)
        ResetButton(action: reset)
      }
    }
  }
}

struct KeyboardButton: View {
  let title: String
  let subtitle: String
  @Binding
  var value: Bool
  
  var body: some View {
    let gesture = DragGesture(
      minimumDistance: 0,
      coordinateSpace: .local
    ).onChanged { _ in value = true }
      .onEnded { _ in value = false }
    VStack {
      Text(title)
      Text(subtitle)
    }
      .frame(width: 50, height: 50)
      .border(.gray)
      .gesture(gesture)
  }
}

struct ResetButton: View {
  let action: () -> Void
  
  var body: some View {
    Button(
      action: action,
      label: {
        Text("RES")
          .frame(width: 50, height: 50)
          .border(.gray)
      }
    )
  }
}

struct DisplayView: View {
  var display: Display
  
  var body: some View {
    HStack {
      SegmentIndicator(value: display.H)
      SegmentIndicator(value: display.I)
      SegmentIndicator(value: display.N)
      SegmentIndicator(value: display.Z)
      SegmentIndicator(value: display.V)
      SegmentIndicator(value: display.C)
    }
  }
}

struct SegmentIndicator: View {
  var value: Display.Indicator
  
  var body: some View {
    VStack(spacing: 1) {
      Rectangle()
        .foregroundColor(value.a ? .red : .disabled)
        .frame(width: 18, height: 3)
      HStack(spacing: 1) {
        Rectangle()
          .foregroundColor(value.f ? .red : .disabled)
          .frame(width: 3, height: 18)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 18, height: 18)
        Rectangle()
          .foregroundColor(value.b ? .red : .disabled)
          .frame(width: 3, height: 18)
      }
      Rectangle()
        .foregroundColor(value.g ? .red : .disabled)
        .frame(width: 18, height: 3)
      HStack(spacing: 1) {
        Rectangle()
          .foregroundColor(value.e ? .red : .disabled)
          .frame(width: 3, height: 18)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 18, height: 18)
        Rectangle()
          .foregroundColor(value.c ? .red : .disabled)
          .frame(width: 3, height: 18)
      }
      HStack(spacing: 0) {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 2, height: 2)
        Rectangle()
          .foregroundColor(value.d ? .red : .disabled)
          .frame(width: 18, height: 3)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 2, height: 2)
        Rectangle()
          .foregroundColor(value.DP ? .red : .disabled)
          .frame(width: 3, height: 3)
      }
    }
  }
}

private extension Color {
  static var disabled: Color {
    Color(red: 1, green: 0, blue: 0, opacity: 0.05)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HeathkitView()
  }
}

private let rom: Data = {
  let url = Bundle.main.url(forResource: "et3400rom", withExtension: "bin")!
  return try! Data(contentsOf: url)
}()
