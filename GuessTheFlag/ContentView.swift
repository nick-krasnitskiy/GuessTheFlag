//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nick Krasnitskiy on 15.01.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button {
            print("Edit button was tapped")
        } label: {
            Label("Edit", systemImage: "pencil")
                .padding()
                .foregroundStyle(.white)
                .background(.yellow)
        }
    }
    
    
}

#Preview {
    ContentView()
}
