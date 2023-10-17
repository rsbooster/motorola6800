import SwiftUI

struct PongView: View {
  @Environment(\.scenePhase) var scenePhase
  
  @State
  private var buffer = Set<Screen.Pixel>()
  private let screen = Screen()
  private let execution: Execution
  
  var body: some View {
    ScreenView(buffer: buffer)
      .onChange(of: scenePhase) { phase in
        switch phase {
        case .active:
          screen.onUpdate = { buffer = $0 }
          execution.run(updateFrequency: { _ in })
        case .inactive, .background:
          execution.stop()
        default:
          break
        }
      }
  }
  
  init() {
    let memory = Memory(
      ram: [],
      inputDevices: [
        Rom(baseAddress: 0x8000, data: Data(Samples.pong)),
        Rom(baseAddress: 0xFFFE, data: Data([0x82, 0x00])),
      ],
      outputDevices: [screen]
    )
    self.execution = Execution(
      memory: memory
    )
  }
}

struct PongView_Previews: PreviewProvider {
  static var previews: some View {
    PongView()
  }
}
