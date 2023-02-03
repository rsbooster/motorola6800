import SwiftUI

struct HeathkitView: View {
  private let keyboard: Keyboard
  private let execution: Execution
  
  init() {
    self.keyboard = Keyboard()
    let memory = Memory(
      ram: Samples.decimalConverter,
      rom: rom,
      inputDevices: [keyboard]
    )
    self.execution = Execution(
      memory: memory
    )
  }
  
  @State
  var display: Display = .filled
  
  
  var body: some View {
    VStack(spacing: 30) {
      DisplayView(display: display)
      KeyboardView(keyboard: keyboard, reset: { execution.reset() })
    }
    .onAppear {
      let output = Binding<OutputDevice>(
        get: { display },
        set: { display = $0 as! Display }
      )
      execution.run(
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
