import SwiftUI

struct KeyboardView: View {
  let keyboard: Keyboard
  let reset: () -> Void
  
  var body: some View {
    VStack {
      HStack {
        KeyboardButton(title: "DO", subtitle: "D", onPress: { keyboard.key_D = $0 })
        KeyboardButton(title: "EXAM", subtitle: "E", onPress: { keyboard.key_E = $0 })
        KeyboardButton(title: "FWD", subtitle: "F", onPress: { keyboard.key_F = $0 })
      }
      HStack {
        KeyboardButton(title: "AUTO", subtitle: "A", onPress: { keyboard.key_A = $0 })
        KeyboardButton(title: "BACK", subtitle: "B", onPress: { keyboard.key_B = $0 })
        KeyboardButton(title: "CHAN", subtitle: "C", onPress: { keyboard.key_C = $0 })
      }
      HStack {
        KeyboardButton(title: "RTI", subtitle: "7", onPress: { keyboard.key_7 = $0 })
        KeyboardButton(title: "SS", subtitle: "8", onPress: { keyboard.key_8 = $0 })
        KeyboardButton(title: "BR", subtitle: "9", onPress: { keyboard.key_9 = $0 })
      }
      HStack {
        KeyboardButton(title: "INDEX", subtitle: "4", onPress: { keyboard.key_4 = $0 })
        KeyboardButton(title: "CC", subtitle: "5", onPress: { keyboard.key_5 = $0 })
        KeyboardButton(title: "SP", subtitle: "6", onPress: { keyboard.key_6 = $0 })
      }
      HStack {
        KeyboardButton(title: "ACCA", subtitle: "1", onPress: { keyboard.key_1 = $0 })
        KeyboardButton(title: "ACCB", subtitle: "2", onPress: { keyboard.key_2 = $0 })
        KeyboardButton(title: "PC", subtitle: "3", onPress: { keyboard.key_3 = $0 })
      }
      HStack {
        KeyboardButton(title: "", subtitle: "0", onPress: { keyboard.key_0 = $0 })
        ResetButton(action: reset)
      }
    }
  }
}

struct KeyboardButton: View {
  let title: String
  let subtitle: String
  let onPress: (Bool) -> Void
  
  var body: some View {
    let gesture = DragGesture(
      minimumDistance: 0,
      coordinateSpace: .local
    ).onChanged { _ in onPress(true) }
      .onEnded { _ in onPress(false) }
    VStack(spacing: 5) {
      Text(title).font(.system(size: 14))
      Text(subtitle).fontWeight(.bold)
    }
      .frame(width: 50, height: 50)
      .border(.gray, width: 2)
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
          .font(.system(size: 14))
      }
    )
    .frame(width: 50, height: 50)
    .foregroundColor(.primary)
    .border(.gray, width: 2)
  }
}

struct KeyboardView_Previews: PreviewProvider {
  static var previews: some View {
    KeyboardView(
      keyboard: .init(),
      reset: {}
    )
  }
}
