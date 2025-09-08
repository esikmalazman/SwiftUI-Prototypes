//
//  ContentView.swift
//  GlowingTextField_SwiftUI
//
//  Created by esikmalazman on 08/09/2025.
//

import SwiftUI

// Example: https://youtu.be/GFjOuH2Utt4?si=EFtc_6UL6gz8eUVO
struct ContentView: View {
  @State private var isAnimating: Bool = false
  
  var body: some View {
    ZStack {
      
      // Animated shadow background, it need to match with what shape it wants shadowing
      RoundedRectangle(cornerRadius: 16, style: .continuous)
      // The angular needs 3 color to smooth the gradient. The animation is start when we play around with the angle
        .fill(AngularGradient(colors: [.teal, .pink, .teal], center: .center, angle: .degrees(isAnimating ? 360 : 0)))
        .frame(width: 260, height: 60)
      // This make the background as a shadow, the radius determine the instensity of the shadow it showing
        .blur(radius: 20)
        .onAppear {
          withAnimation(.linear(duration: 6).repeatForever(autoreverses: false)) {
            self.isAnimating = true
          }
        }
      
      
      
      Button {
        // Action
      } label: {
        Text("Subscribe")
          .fontWeight(.semibold)
          .fontDesign(.serif)
          .foregroundStyle(.black)
          .frame(width: 260, height: 60)
          .background(.teal, in: .rect(cornerRadius: 16, style: .continuous))
          .overlay {
            // Add stroke
            RoundedRectangle(
              cornerRadius: 16,
              style: .continuous
            ).stroke(.gray, lineWidth: 2)
          }
      }
      
    }
    
  }
}

#Preview {
  ContentView()
}
