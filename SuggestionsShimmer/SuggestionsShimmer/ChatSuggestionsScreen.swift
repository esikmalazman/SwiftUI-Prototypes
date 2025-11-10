//
//  ChatSuggesionsScreen.swift
//  SuggestionsShimmer
//
//  Created by esikmalazman on 10/11/2025.
//

import SwiftUI

struct SuggestionBox: View {
  var title: String = ""
  @Binding var isLoading: Bool
  
  var body: some View {
    if isLoading {
      Label {
        Text(title)
          .redacted(reason: isLoading ? .placeholder : [])
      } icon: {
        Image(systemName: "wand.and.sparkles")
      }
      .shimmer()
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 1)
          .foregroundStyle(.indigo)
      )
    } else {
      Label {
        Text(title)
          .redacted(reason: isLoading ? .placeholder : [])
      } icon: {
        Image(systemName: "wand.and.sparkles")
      }
      .padding()
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 1)
          .foregroundStyle(.indigo)
      )
    }
  }
}
struct ChatSuggestionsScreen: View {
  
  @State var animate: Bool = false
  @State var shouldFetchSuggestion: Bool = true
  
  var body: some View {
    VStack(alignment: .leading) {

      Text("Follow up suggestions")
        .font(.subheadline)
        .foregroundStyle(.black.secondary)

   
      SuggestionBox(title: "How to make cookies dough?", isLoading: $shouldFetchSuggestion)
      SuggestionBox(title: "How to make cookies dough?", isLoading: $shouldFetchSuggestion)
      SuggestionBox(title: "How to make cookies dough?", isLoading: $shouldFetchSuggestion)
      
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        shouldFetchSuggestion = false
      }
    }
    
  }
  
  
  var otherView: some View {
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
