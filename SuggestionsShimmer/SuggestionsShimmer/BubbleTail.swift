//
//  BubbleTail.swift
//  SuggestionsShimmer
//
//  Created by esikmalazman on 11/11/2025.
//

import SwiftUI


struct BubbleTail: Shape {
  enum TailDirection: CaseIterable, Identifiable {
    case topRight, topLeft, bottomLeft, bottomRight
    
    var id: Self { self }
  }
  
  let direction: TailDirection
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      switch direction {
      case .topRight:
        let startPoint = CGPoint(x: rect.minX, y: rect.maxY)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        let control1 = CGPoint(x: rect.maxX - rect.maxX / 20, y: rect.minY - rect.maxY / 3)
        let control2 = CGPoint(x: rect.maxX * 5 / 6, y: rect.maxY * 5 / 6)
        path.addCurve(to: startPoint, control1: control1, control2: control2)
      case .topLeft:
        let startPoint = CGPoint(x: rect.maxX, y: rect.maxY)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        let control1 = CGPoint(x: rect.maxX / 20, y: rect.minY - rect.maxY / 3)
        let control2 = CGPoint(x: rect.maxX * 1 / 6, y: rect.maxY * 5 / 6)
        path.addCurve(to: startPoint, control1: control1, control2: control2)
      case .bottomLeft:
        let startPoint = CGPoint(x: rect.minX, y: rect.maxY)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        
        let control1 = CGPoint(x: rect.maxX / 6, y: rect.maxY / 6)
        let control2 = CGPoint(x: rect.minX + rect.maxX / 20, y: rect.maxY + rect.maxY / 3)
        path.addCurve(to: startPoint, control1: control1, control2: control2)
      case .bottomRight:
        let startPoint = CGPoint(x: rect.minX, y: rect.minY)
        path.move(to: startPoint)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        
        let control1 = CGPoint(x: rect.maxX - rect.maxX / 20, y: rect.maxY + rect.maxY / 3)
        let control2 = CGPoint(x: rect.maxX * 5 / 6, y: rect.maxY * 1 / 6)
        path.addCurve(to: startPoint, control1: control1, control2: control2)
      }
    }
  }
}
#Preview {
  HStack {
  Text("Hello")
      .padding()
      .foregroundStyle(.white)
      .background {
        UnevenRoundedRectangle(
          topLeadingRadius: 16,
          bottomLeadingRadius: 24,
          bottomTrailingRadius: .zero,
          topTrailingRadius: 24,
          style: .continuous
        )
      }
    
//        Rectangle()
//          .clipShape(BubbleTail(direction: .bottomRight))
//          .foregroundStyle(.blue)
   
  }
  .frame(height: 100)
}
