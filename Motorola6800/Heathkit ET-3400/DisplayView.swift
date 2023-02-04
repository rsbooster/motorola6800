import SwiftUI

struct DisplayView: View {
  var display: Display
  
  var body: some View {
    HStack(spacing: 20) {
      SegmentIndicatorView(value: display.H)
      SegmentIndicatorView(value: display.I)
      SegmentIndicatorView(value: display.N)
      SegmentIndicatorView(value: display.Z)
      SegmentIndicatorView(value: display.V)
      SegmentIndicatorView(value: display.C)
    }
  }
}

struct DisplayView_Previews: PreviewProvider {
  static var previews: some View {
    DisplayView(display: .filled)
  }
}
