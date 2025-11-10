//
//  ContentView.swift
//  SuggestionsShimmer
//
//  Created by esikmalazman on 08/11/2025.
//  https://www.shoutdigital.com/insights/shine-effect-in-swiftui/

import SwiftUI

struct ShimmerImageExample: View {
  
  // 3. Animate offset across view depends on the state change.
  // In this example we start when screen appear.
  @State var animate: Bool = false
  
  var body: some View {
    // 1. Setup the view to apply the shine effect
    ZStack {
      Color.black.ignoresSafeArea()
      Image(systemName: "globe")
        .resizable()
        .scaledToFit()
        .foregroundStyle(.tint)
      
      
      // 2. Create gradient white in the middle, fade in and out at both side ends
      LinearGradient(
        gradient: Gradient(
          colors: [
            .clear,
            .clear,
            .white.opacity(0.3),
            .white,
            .white.opacity(0.3),
            .clear,
            .clear
          ]
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
      // Set the height of the gradient, has to be bigger than image
      .frame(width: .infinity, height: .infinity)
      // Apply slight rotation to make it looks natural and improve shine effect
      .rotationEffect(.degrees(20))
      // Offset to position the gradient off the screen initially
      // (can use geometry reader to get accurate value of screen width)
      .offset(x: -350)
      // This value is asjustable
      .offset(x: animate ? 750 : -350)
      
      // 4. Apply mask to the gradient to aligns with the image under it and give shine effect.
      // We apply same shape/view as mask to match view we want to hightlight
      .mask {
        Image(systemName: "globe")
          .resizable()
          .scaledToFit()
          .foregroundStyle(.tint)
        
      }
    }
    .onAppear {
      withAnimation(
        .linear(duration: 2.5).repeatForever(autoreverses: false)
      ) {
        self.animate = true
      }
    }
    
  }
}

#Preview {
  ShimmerImageExample()
}
