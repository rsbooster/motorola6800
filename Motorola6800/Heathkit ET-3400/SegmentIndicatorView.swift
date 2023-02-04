import SwiftUI

struct SegmentIndicatorView: View {
  var value: Display.Indicator
  let width: Int = 30
  let gap: Int = 3
  
  var body: some View {
    ZStack {
      makeSegment(from: CGPoint(x: gap, y: 0), to: CGPoint(x: width - gap, y: 0), enabled: value.a)
      makeSegment(from: CGPoint(x: width, y: gap), to: CGPoint(x: width, y: width - gap), enabled: value.b)
      makeSegment(from: CGPoint(x: width - gap, y: width), to: CGPoint(x: gap, y: width), enabled: value.g)
      makeSegment(from: CGPoint(x: 0, y: width - gap), to: CGPoint(x: 0, y: gap), enabled: value.f)
      makeSegment(from: CGPoint(x: 0, y: width + gap), to: CGPoint(x: 0, y: 2 * width - gap), enabled: value.e)
      makeSegment(from: CGPoint(x: gap, y: 2 * width), to: CGPoint(x: width - gap, y: 2 * width), enabled: value.d)
      makeSegment(from: CGPoint(x: width, y: 2 * width - gap), to: CGPoint(x: width, y: width + gap), enabled: value.c)
      makeSegment(from: CGPoint(x: width + 8, y: 2 * width), to: CGPoint(x: width + 9, y: 2 * width), enabled: value.DP)
    }
    
    .frame(width: CGFloat(width), height: 2 * CGFloat(width))
    .transformEffect(.init(a: 1, b: 0, c: -0.15, d: 1, tx: 0, ty: 0))
  }
}

private func makeSegment(
  from: CGPoint,
  to: CGPoint,
  enabled: Bool
) -> some View {
  Path {
    $0.move(to: from)
    $0.addLine(to: to)
  }
  .stroke(style: .init(lineWidth: 3, lineCap: .square))
  .foregroundColor(enabled ? .red : .disabled)
}

private extension Color {
  static var disabled: Color {
    Color(red: 1, green: 0, blue: 0, opacity: 0.05)
  }
}

struct SegmentIndicatorView_Previews: PreviewProvider {
  static var previews: some View {
    SegmentIndicatorView(value: .filled)
  }
}
