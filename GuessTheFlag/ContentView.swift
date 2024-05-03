//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nick Krasnitskiy on 03.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Your content")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundStyle(.white)
            .background(.red.gradient)
    }
}

#Preview {
    ContentView()
}
