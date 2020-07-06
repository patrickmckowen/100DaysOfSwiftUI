//
//  ContentView.swift
//  Animations
//
//  Created by McKowen, Patrick on 7/6/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    @State private var animationDegree = 0.0
    
    @State private var dragAmount = CGSize.zero
    
    @State private var isShowingCard = false
    
    let letters = Array("Try Dragging Me")
    @State private var enabled = false
    @State private var dragLettersAmount = CGSize.zero
    
    var body: some View {
        VStack {
            Spacer()
                HStack(spacing: 0) {
                    ForEach(0..<letters.count) { num in
                        Text(String(self.letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(self.enabled ? Color.blue : Color.red)
                            .offset(self.dragLettersAmount)
                            .animation(Animation.default.delay(Double(num) / 20))
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { self.dragLettersAmount = $0.translation }
                        .onEnded { _ in
                            self.dragLettersAmount = .zero
                            self.enabled.toggle()
                        }
                )
            
            Spacer()
            
          //  Button("Tap Me") {
          //     // self.animationAmount += 1
          //  }
          //  .padding(50)
          //  .background(Color.blue)
          //  .foregroundColor(.white)
          //  .clipShape(Circle())
          //  .overlay(
          //      Circle()
          //          .stroke(Color.blue)
          //          .scaleEffect(animationAmount)
          //          .opacity(Double(2 - animationAmount))
          //          .animation(
          //              Animation.easeOut(duration: 1.5)
          //                  .repeatForever(autoreverses: false)
          //          )
          //  )
          // .onAppear { self.animationAmount = 2 }
          //   Spacer()
            
            Button("Tap Me") {
                withAnimation {
                    self.animationDegree += 360
                    self.isShowingCard.toggle()
                }
            }
            .padding(50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(Circle())
            .rotation3DEffect(.degrees(animationDegree), axis: (x: 0, y: 45, z: 0))
            
            Spacer()
            
            if isShowingCard {
                LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 327, height: 196)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { self.dragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    self.dragAmount = .zero
                                }
                            }
                    )
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
            
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
