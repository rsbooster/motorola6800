import SwiftUI

@main
struct Motorola6800App: App {
  var body: some Scene {
    WindowGroup {
      if eta3400x {
        HeathkitView(
          terminalBaseAddress: 0xC200,
          roms: [
            Rom(file: "eta_monitor_up", baseAddress: 0xF400),
            Rom(file: "et3400rom", baseAddress: 0xFC00),
          ],
          external: [
            Rom(file: "altair_680_basic", baseAddress: 0)
          ]
        )
      } else {
        HeathkitView(
          roms: [
            Rom(file: "eta_monitor", baseAddress: 0x1400),
            Rom(file: "eta_basic", baseAddress: 0x1C00),
            Rom(file: "et3400rom", baseAddress: 0xFC00),
          ]
        )
      }
    }
  }
}

private let eta3400x = false
