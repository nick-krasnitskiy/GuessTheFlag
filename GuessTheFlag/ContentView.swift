//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nick Krasnitskiy on 15.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var showingFinalAlert = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var userScore: Int = 0
    @State private var numberOFQuestions: Int = 0
    @State private var isRotate = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .largeYellowTitle()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(contries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(imageName: contries[number])
                                .rotation3DEffect(isRotate ? .degrees(360) : .zero, axis: (0, 1, 0))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
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
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Congtatulation!", isPresented: $showingFinalAlert) {
            Button("Reset the game", action: reset)
        } message: {
            Text("Your final score is \(userScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        numberOFQuestions += 1
        
        if number == correctAnswer {
            isRotate.toggle()
            userScore += 1
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(userScore)"
        } else {
            userScore -= 1
            scoreTitle = "Wrong"
            scoreMessage = "That’s the flag of \(contries[number]). Your score is \(userScore)"
        }
        
        if numberOFQuestions < 8 {
            showingScore = true
        } else {
            showingFinalAlert = true
        }
        
    }
    
    func askQuestion() {
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        numberOFQuestions = 0
        userScore = 0
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(.yellow)
    }
}

extension View {
    func largeYellowTitle() -> some View {
        modifier(Title())
    }
}

#Preview {
    ContentView()
}
