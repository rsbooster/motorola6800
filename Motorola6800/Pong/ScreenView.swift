import CoreGraphics
import SwiftUI

struct ScreenView: View {
  var buffer: Set<Screen.Pixel>
  
  var body: some View {
    GeometryReader { geometry in
      buffer
        .makePath(size: geometry.size)
        .fill()
        .background { Color(.lightGray) }
    }.aspectRatio(originalSize, contentMode: .fit)
  }
}

private extension Collection where Element == Screen.Pixel {
  func makePath(size: CGSize) -> Path {
    var path = Path()
    for pixel in self {
      path.addRect(pixel.makeRectangle(for: size))
    }
    return path
  }
}

private extension Screen.Pixel {
  func makeRectangle(for size: CGSize) -> CGRect {
    CGRect(
      x: CGFloat(x) / originalSize.width * size.width,
      y: CGFloat(y) / originalSize.height * size.height,
      width: floor(size.width / originalSize.width),
      height: floor(size.height / originalSize.height)
    )
  }
}

private let originalSize = CGSize(width: 200, height: 150)

struct ScreenView_Previews: PreviewProvider {
  static var previews: some View {
    ScreenView(buffer: [
      .init(x: 0, y: 0),
      .init(x: 100, y: 100),
    ])
  }
}
