//
//  ChatSuggesionsScreen.swift
//  SuggestionsShimmer
//
//  Created by esikmalazman on 10/11/2025.
//

import SwiftUI

struct ChatSuggestionsScreen: View {
  @State private var shouldFetchSuggestion: Bool = true
  @State private var shouldDisplaySuggestion: Bool = false
  @State private var response: String = ""
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        userPromptRow
        responsePromptRow
      }
      .padding()
    }
  }
  
  var userPromptRow: some View {
    VStack(alignment: .trailing,spacing: 0) {
      Image(.image)
        .resizable()
        .scaledToFit()
        .frame(height: 200)
        .clipShape(.rect(cornerRadius: 16))
        .padding(.bottom, 8)
      
      
      Text("What is the name of this pastries?")
        .font(.subheadline)
        .fontDesign(.serif)
        .padding()
        .foregroundStyle(.white)
        .background {
          UnevenRoundedRectangle(
            topLeadingRadius: 8,
            bottomLeadingRadius: 8,
            bottomTrailingRadius: 16,
            topTrailingRadius: 4,
            style: .continuous
          )
        }
    }
    .frame(maxWidth: .infinity, alignment: .trailing)
  }
  var responsePromptRow: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(response)
        .fontDesign(.serif)
        .task{
          await animateText()
          await animateSuggestions()
        }
      
      
      if shouldDisplaySuggestion {
        VStack(alignment: .leading) {
          if shouldFetchSuggestion {
            Text("Follow up suggestions")
              .font(.subheadline)
              .foregroundStyle(.black.secondary)
          }
          
          
          SuggestionBox(
            title: "Can you share an easy recipe for making it at home?",
            isLoading: $shouldFetchSuggestion
          )
          SuggestionBox(
            title: "What is the history or origin of the pastry?",
            isLoading: $shouldFetchSuggestion
          )
          SuggestionBox(
            title: "Where can I find a good Tebirkes near me?",
            isLoading: $shouldFetchSuggestion
          )
        }.task {
          
        }
      }
      
    }
    .padding(.top)
  }
}

#Preview {
  ChatSuggestionsScreen()
}



extension ChatSuggestionsScreen {
  // Typewriter animation
  // https://stackoverflow.com/a/76349117
  func animateText() async {
    let text = """
Based on the image of the flaky, poppy-seed-topped pastry, the name of this specific Danish item is a Tebirkes (pronounced teh-burk-iss)

It is a classic Danish pastry (wienerbrød) known for its buttery, laminated dough and typically contains a sweet filling called remonce (often made with butter, sugar, and marzipan).
"""
    
    // Iterate and append the text one by one
    for character in text {
      response.append(character)
      try! await Task.sleep(for: .milliseconds(15))
    }
  }
  
  // Display suggestions animation
  func animateSuggestions() async {
    try! await Task.sleep(for: .milliseconds(450))
    withAnimation {
      self.shouldDisplaySuggestion = true
    }
    
    try! await Task.sleep(for: .milliseconds(3000))
    
    withAnimation {
      shouldFetchSuggestion = false
    }
  }
}

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
      .frame(maxWidth: .infinity)
    } else {
      Label {
        Text(title)
          .font(.body)
          .fontDesign(.serif)
          .redacted(reason: isLoading ? .placeholder : [])
      } icon: {
        Image(systemName: "wand.and.sparkles")
      }
      .padding()
      .frame(maxWidth: .infinity, alignment: .leading)
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(lineWidth: 0.5)
          .foregroundStyle(.indigo)
      )
      
    }
  }
}
