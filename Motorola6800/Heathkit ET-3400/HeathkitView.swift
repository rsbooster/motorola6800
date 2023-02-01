import SwiftUI

struct HeathkitView: View {
  private let execution = Execution(
    ram: Samples.decimalCounter,
    rom: rom
  )
  
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HeathkitView()
  }
}

private let rom: Data = {
  let url = Bundle.main.url(forResource: "et3400rom", withExtension: "bin")!
  return try! Data(contentsOf: url)
}()
