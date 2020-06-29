//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by McKowen, Patrick on 6/26/20.
//  Copyright © 2020 Patrick McKowen. All rights reserved.
//

import SwiftUI

struct FlagStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(8)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.16), radius: 24, x: 0, y: 24)
            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.08), radius: 4, x: 0, y: 0)
    }
}

extension View {
    func flagStyle() -> some View {
        self.modifier(FlagStyle())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var roundsPlayed = 0
    @State private var roundsCorrect = 0
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertBody = ""
    
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.98, blue: 0.96, opacity: 1.0).edgesIgnoringSafeArea(.all)
            
            VStack() {
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding(.top, 8)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0)
    
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .flagStyle()
                    }
                }
                .padding(.top, 32.0)
                Spacer()
                VStack() {
                    Text("Score")
                        .font(.headline)
                        .padding(.bottom, 8.0)
                    HStack(alignment: .center) {
                        Text("\(roundsCorrect)")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .font(.title)
                        Text("out of")
                            .fixedSize(horizontal: true, vertical: false)
                            .foregroundColor(.gray)
                             .font(.body)
                        Text("\(roundsPlayed)")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text("\(alertBody)"), dismissButton: .default(Text("Next Flag")) {
                self.askQuestion()
                })
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            alertTitle = "Correct!"
            alertBody = "Nice job."
            roundsCorrect += 1
        } else {
            alertTitle = "Wrong"
            alertBody = "Oops. That's the flag of \(countries[number])."
        }
        roundsPlayed += 1
        showingAlert = true
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
