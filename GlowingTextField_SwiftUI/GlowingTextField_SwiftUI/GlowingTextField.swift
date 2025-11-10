//
//  GlowingTextField.swift
//  GlowingTextField_SwiftUI
//
//  Created by esikmalazman on 08/09/2025.
//

import SwiftUI

struct GlowingTextField: View {
  @State private var userPrompt: String = ""
  @State private var isAnimating: Bool = false
  @State private var isSendButtonEnable: Bool = false
  @FocusState private var isTextPrompFocused: Bool
  
  var isUserPromptValid: Bool {
    return userPrompt.isEmpty == false
  }
  
  
  var body: some View {
    VStack {
      Spacer()
      
      ZStack {
        RoundedRectangle(cornerRadius: 16, style: .continuous)
          .fill(
            AngularGradient(
              colors: [Color(hex: "81E180"), Color(hex: "45B87C"), Color(hex: "81E180")],
              center: .center,
              angle: .degrees(isAnimating ? 360 : 0)
            )
          )
          .frame(maxWidth: .infinity, maxHeight: 48)
          .blur(radius: isTextPrompFocused ? 24 : 8)
          .animation(.default, value: isTextPrompFocused)
          .onAppear {
            withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
              self.isAnimating = true
            }
          }
        
        
        HStack {
          TextField("How can I help you today?", text: $userPrompt)
            .focused($isTextPrompFocused)
            .onChange(of: userPrompt) { oldValue, newValue in
              guard isUserPromptValid else {
                isSendButtonEnable = false
                return
              }
              isSendButtonEnable = true
            }
            
          

          
          Button {
            guard isUserPromptValid else {return}
            // Send message action
            withAnimation {
              isTextPrompFocused = false
              userPrompt = ""
            }
         
          } label: {
          
            Image(systemName: isSendButtonEnable ? "arrow.up.circle.fill" : "arrow.up" )
              .foregroundStyle(isSendButtonEnable ? Color(hex: "45B87C") : Color.secondary.opacity(0.5))
  
      
          }
          .font(.title3)
          .contentTransition(.symbolEffect(.replace.offUp))
      
        }
        .padding(.all)
        .frame(maxWidth: .infinity, maxHeight: 48)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(.white))
        .overlay {
          // Border
          RoundedRectangle(cornerRadius: 16, style: .continuous)
            .stroke(lineWidth: 1)
            .foregroundStyle(Color(hex: "45B87C"))
            .opacity(isTextPrompFocused ? 1 : 0)
        }
      }
      .padding()
      
    }
  }
}

#Preview {
  GlowingTextField()
}

extension Color {
  static var redFlare: Color { .init(hex: "#f12711")}
  static var orangeFlare: Color { .init(hex: "#f5af19")}
}
