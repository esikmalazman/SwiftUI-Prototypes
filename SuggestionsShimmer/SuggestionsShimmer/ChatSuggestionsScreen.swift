//
//  ChatSuggesionsScreen.swift
//  SuggestionsShimmer
//
//  Created by esikmalazman on 10/11/2025.
//

import SwiftUI

struct ChatSuggestionsScreen: View {
  
  @State var animate: Bool = false
  
  var body: some View {
    ZStack {
      Text("Creating suggestions")
        .font(.largeTitle)
      
      LinearGradient(
        gradient: Gradient(
          colors: [
            .clear,
            .clear,
            .indigo.opacity(0.3),
            .indigo,
            .indigo.opacity(0.3),
            .clear,
            .clear
          ]
        ),
        startPoint: .leading,
        endPoint: .trailing
      )
      .frame(width: .infinity, height: .infinity)
      .rotationEffect(.degrees(20))
      .offset(x: -350)
      .offset(x: animate ? 750 : -350)
      .mask {
        Text("Creating suggestions")
          .font(.largeTitle)
      }
    }
    .onAppear {
      withAnimation(
        .linear(duration: 3).repeatForever(autoreverses: false)
      ) {
        self.animate = true
      }
    }
    
  }
}

#Preview {
  ChatSuggestionsScreen()
}
