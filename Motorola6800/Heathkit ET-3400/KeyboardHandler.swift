import SwiftUI
import UIKit

struct KeyboardHandler: UIViewRepresentable {
  typealias UIViewType = UIView
  
  private let onKey: (String) -> Void
  
  init(onKey: @escaping (String) -> Void) {
    self.onKey = onKey
  }
  
  func makeUIView(context: Context) -> UIView {
    KeyboardHandlerView(onKey: onKey)
  }
  
  func updateUIView(_ uiView: UIView, context: Context) {
  }
  
  func sizeThatFits(_ proposal: ProposedViewSize, uiView: UIView, context: Context) -> CGSize? {
    CGSize(width: 50, height: 50)
  }
}

private final class KeyboardHandlerView: UIView {
  private let onKey: (String) -> Void
  
  init(onKey: @escaping (String) -> Void) {
    self.onKey = onKey
    super.init(frame: .zero)
    backgroundColor = .placeholderText
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var canBecomeFirstResponder: Bool {
    true
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if isFirstResponder {
      resignFirstResponder()
      backgroundColor = .placeholderText
    } else {
      becomeFirstResponder()
      backgroundColor = .darkText
    }
  }
  
  override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
    let string = presses
      .compactMap { $0.key }
      .flatMap { $0.characters }
      .filter { $0.isASCII }
      .map { String($0) }
      .joined()
    if string.isEmpty {
      return
    }
    onKey(string)
  }
}
