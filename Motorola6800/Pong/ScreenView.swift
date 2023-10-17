import CoreGraphics
import SwiftUI

struct ScreenView: View {
  var buffer: Set<Screen.Pixel>
  
  var body: some View {
    Path(buffer.path)
      .stroke(style: .init(lineWidth: 1, lineCap: .round))
      .frame(width: 200, height: 150)
      .padding(.init(top: 1, leading: 1, bottom: 0, trailing: 0))
      .background { Color(.lightGray) }
      .scaleEffect(4)
  }
}

private extension Collection where Element == Screen.Pixel {
  var path: CGPath {
    let path = CGMutablePath()
    for pixel in self {
      path.move(to: pixel.point)
      path.addLine(to: pixel.point)
    }
    return path
  }
}

private extension Screen.Pixel {
  var point: CGPoint {
    CGPoint(x: Int(x), y: Int(y))
  }
}

struct ScreenView_Previews: PreviewProvider {
  static var previews: some View {
    ScreenView(buffer: [])
  }
}
