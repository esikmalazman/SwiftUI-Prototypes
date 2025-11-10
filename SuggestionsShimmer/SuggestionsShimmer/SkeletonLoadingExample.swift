//
//  SkeletonLoadingExample.swift
//  SuggestionsShimmer
//
//  Created by esikmalazman on 10/11/2025.
// https://towardsdev.com/enhancing-ux-with-redaction-in-swiftui-skeleton-loading-data-protection-492f9b8e5d8c 

import SwiftUI

struct SkeletonLoadingExample: View {
  @State var basicExampleIsLoading: Bool = true
  @State var multipleViewExampleIsLoading: Bool = true
  @State var animatedSkeletonViewIsLoading: Bool = true
  
  @State var user: User?
  @State var article: Article?
  
  var body: some View {
    VStack {
      basicExample
      multipleViewAtOnceExample
      animatedSkeletonExample
    }
    
  }
  
  var animatedSkeletonExample: some View {
    VStack {
      if let article = article {
        Text(article.title)
          .font(.title)
        
        Text(article.description)
          .font(.subheadline)
      } else {
        Text("Loading title...")
          .font(.title)
          .redacted(reason: animatedSkeletonViewIsLoading ? .placeholder : [])
          .shimmer()
        
        
        Text("Loading description...")
          .font(.subheadline)
          .redacted(reason: animatedSkeletonViewIsLoading ? .placeholder : [])
          .shimmer()
      }
      
      Button("Load article") {
        self.animatedSkeletonViewIsLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.article = Article(title: "El Classico", description: "Real Madrid vs Barcelona")
          self.animatedSkeletonViewIsLoading = false
        }
      }
    }
  }
  
  var multipleViewAtOnceExample: some View {
    VStack {
      if let user = user {
        Text(user.name)
          .font(.title)
        
        Text(user.bio)
          .font(.subheadline)
      } else {
        VStack {
          Text("Loading name...")
            .font(.title)
          
          Text("Loading bio..")
            .font(.subheadline)
          
        }
        .redacted(reason: multipleViewExampleIsLoading ? .placeholder : [])
        
      }
      
      Button("Load Profile") {
        self.multipleViewExampleIsLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.user = User(name: "John Doe", bio: "Hello, I am John Doe")
          self.multipleViewExampleIsLoading = false
        }
      }
    }
  }
  var basicExample: some View {
    VStack {
      Text("Hello, World!")
        .font(.title)
        .redacted(reason: basicExampleIsLoading ? .placeholder : [])
      
      
      Image(systemName: "star.fill")
        .resizable()
        .frame(width: 50, height: 50)
        .redacted(reason: basicExampleIsLoading ? .placeholder : [])
      
      
      Button("Refresh") {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
          self.basicExampleIsLoading = false
        }
      }
      
    }
  }
}

struct User {
  let name: String
  let bio: String
}

struct Article {
  let title: String
  let description: String
}

// View Modifier to apply shimmer effect for skeletion view
struct ShimmerEffect: ViewModifier {
  @State private var isShimmering =  false
  func body(content: Content) -> some View {
    content
      .mask {
        Rectangle()
          .fill(
            LinearGradient(
              colors: [.clear, .white.opacity(0.8),.clear],
              startPoint: .leading,
              endPoint: .trailing
            )
          )
          .offset(x: isShimmering ? 200 : -200)
      }
      .onAppear {
        withAnimation(
          .linear(duration: 1.5).repeatForever(autoreverses: false)
        ) {
          self.isShimmering.toggle()
        }
      }
  }
}
extension View {
  func shimmer() -> some View {
    self.modifier(ShimmerEffect())
  }
}

#Preview {
  SkeletonLoadingExample()
}
