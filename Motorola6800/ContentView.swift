//
//  ContentView.swift
//  Motorola6800
//
//  Created by Roman Solyah on 06.01.2023.
//

import SwiftUI

struct ContentView: View {
  @State
  var display: Display = .filled
    var body: some View {
        HStack {
          SegmentIndicator(value: display.H)
          SegmentIndicator(value: display.I)
          SegmentIndicator(value: display.N)
          SegmentIndicator(value: display.Z)
          SegmentIndicator(value: display.V)
          SegmentIndicator(value: display.C)
        }
        .onAppear {
          execute(display: $display)
        }
    }
}

struct SegmentIndicator: View {
  var value: Display.Indicator
  
  var body: some View {
    VStack(spacing: 1) {
      Rectangle()
        .foregroundColor(value.a ? .red : .clear)
        .frame(width: 18, height: 1)
      HStack(spacing: 1) {
        Rectangle()
          .foregroundColor(value.f ? .red : .clear)
          .frame(width: 1, height: 18)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 18, height: 18)
        Rectangle()
          .foregroundColor(value.b ? .red : .clear)
          .frame(width: 1, height: 18)
      }
      Rectangle()
        .foregroundColor(value.g ? .red : .clear)
        .frame(width: 18, height: 1)
      HStack(spacing: 1) {
        Rectangle()
          .foregroundColor(value.e ? .red : .clear)
          .frame(width: 1, height: 18)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 18, height: 18)
        Rectangle()
          .foregroundColor(value.c ? .red : .clear)
          .frame(width: 1, height: 18)
      }
      HStack(spacing: 0) {
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 2, height: 2)
        Rectangle()
          .foregroundColor(value.d ? .red : .clear)
          .frame(width: 18, height: 1)
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 2, height: 2)
        Rectangle()
          .foregroundColor(value.DP ? .red : .clear)
          .frame(width: 2, height: 2)
      }
    }
    .background { Color(.yellow) }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

private extension Display {
  static var filled: Self {
    Display(
      H: .filled,
      I: .filled,
      N: .filled,
      Z: .filled,
      V: .filled,
      C: .filled
    )
  }
}

private extension Display.Indicator {
  static var filled: Self {
    Display.Indicator(
      a: true,
      b: true,
      c: true,
      d: true,
      e: true,
      f: true,
      g: true,
      DP: true
    )
  }
}
