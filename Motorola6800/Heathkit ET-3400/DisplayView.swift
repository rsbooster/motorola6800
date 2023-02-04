import SwiftUI

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

struct DisplayView_Previews: PreviewProvider {
  static var previews: some View {
    DisplayView(display: .filled)
  }
}

