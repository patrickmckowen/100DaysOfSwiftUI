//
//  AltVersion.swift
//  GuessTheFlag
//
//  Created by Jim Flemming
//  Copyright © 2020 Jim Flemming. All rights reserved.
//

import SwiftUI

enum AnswerStatus {
    case unanswered, correct, incorrect
}

struct ContentView2: View {
    let animationTime = 0.25
    let affirmations = ["Way To Go!", "You Got It!", "Oh Yeah!", "Damn Straight!", "Nailed It!", "Boo-yah!"].shuffled()
    let encouragements = ["Darn!", "Try again!", "So close!", "Almost!", "Shoot!", "Next time!"].shuffled()
    @State private var numCorrect = 0
    @State private var numIncorrect = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US" ].shuffled()
    @State private var correctAnswerNum = Int.random(in: 0...2)
    @State private var answerStatus = AnswerStatus.unanswered
    @State private var tappedNum = 0
    @State private var message = Array("")
    @State private var animationInterval = 0.0

    var body: some View {
        ZStack {
            LinearGradient(gradient:
                Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack (spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswerNum])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0..<3) { number in
                    Button(action: {
                        withAnimation(.linear(duration: self.animationTime)) {
                            self.flagTapped(number)
                        }
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
                    .rotation3DEffect(.degrees(self.answerStatus == AnswerStatus.correct && self.tappedNum == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.answerStatus != AnswerStatus.unanswered && self.tappedNum != number ? 0.25 : 1.0)
                    .disabled(self.answerStatus != AnswerStatus.unanswered)
                }
                VStack (alignment: .leading) {
                    Text("Number correct: \(numCorrect)")
                        .foregroundColor(.white)
                    Text("Number incorrect: \(numIncorrect)")
                        .foregroundColor(.white)
                }
                Spacer()
            }
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    ForEach(0 ..< self.message.count, id: \.self) { num in
                        Text(String(self.message[num]))
                            .foregroundColor(self.answerStatus == AnswerStatus.correct ? Color.green : Color.red)
                            .font(.title)
                            .fontWeight(.black)
                            .padding(1)
                            .transition(AnyTransition.asymmetric(
                                insertion: AnyTransition.opacity.animation(Animation.easeIn.delay(Double(num) * self.animationInterval)),
                                removal: AnyTransition.opacity.animation(Animation.easeOut))
                        )
                    }
                }
            }
        }
    }

    func flagTapped(_ number: Int) {
        self.tappedNum = number
        if correctAnswerNum == number {
            numCorrect += 1
            self.answerStatus = AnswerStatus.correct
            self.message = Array(affirmations[Int.random(in: 0 ..< affirmations.count)])
            self.animationInterval = animationTime / Double(self.message.count)
            DispatchQueue.main.asyncAfter(deadline: .now() + animationTime + 1) {
                self.askQuestion(true)
            }
        } else {
            numIncorrect += 1
            answerStatus = AnswerStatus.incorrect
            self.message = Array(encouragements[Int.random(in: 0 ..< encouragements.count)])
            self.animationInterval = animationTime / Double(self.message.count)
            DispatchQueue.main.asyncAfter(deadline: .now() + animationTime + 1) {
                self.askQuestion(false)
            }
        }
    }

    func askQuestion(_ advanceToNext: Bool) {
        if advanceToNext {
            countries.shuffle()
            correctAnswerNum = Int.random(in: 0...2)
        }
        answerStatus = AnswerStatus.unanswered
        message = Array("")
    }
}



struct AltVersion_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
