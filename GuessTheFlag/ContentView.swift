//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nick Krasnitskiy on 15.01.2024.
//

import SwiftUI

struct ContentView: View {
    var contries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                    Text(contries[correctAnswer])
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        // the flag wa tapped
                    } label: {
                        Image(contries[number])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
