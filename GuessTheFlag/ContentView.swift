//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nick Krasnitskiy on 03.05.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var message = ""
    @State private var userScore = 0
    @State private var questionCount = 0
   
    @State private var animationAmount = 0.0
    @State private var scaleAmount = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .setProminentTitle()
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                                .scaleEffect(scaleAmount)
                                .animation(.linear(duration: 1), value: scaleAmount)
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
                                .opacity(number == correctAnswer ? 1 : 0.25)
                        }
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            questionCount < 8 ? Button("Continue", action: askQuestion) : Button("Reset", action: reset)
        } message: {
            Text(message)
        }
    }
    
    func flagTapped(_ number: Int) {
        if questionCount < 8 {
            if number == correctAnswer {
                userScore += 1
                scoreTitle = "Correct"
                message = "Your score is \(userScore)"
            } else {
                userScore -= 1
                scoreTitle = "Wrong"
                message = "Wrong! That’s the flag of \(countries[number]). Your score is \(userScore)"
            }
        } else {
            scoreTitle = "The End"
            message = "You final score is \(userScore)"
        }
    
        scaleAmount += 0.1
        animationAmount += 360
        showingScore = true
    }
    
    func askQuestion() {
        questionCount += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        scaleAmount = 1.0
    }
    
    func reset() {
        questionCount = 0
        userScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct ProminentTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func setProminentTitle() -> some View {
        modifier(ProminentTitle())
    }
}

#Preview {
    ContentView()
}
