//
//  ContentView.swift
//  GuidedGeneration
//
//  Created by Mohammad Azam on 6/19/26.
//

import SwiftUI
import FoundationModels
import Playgrounds

#Playground("Playground") {
    
    let session = LanguageModelSession(instructions: """
                                           
                                           You are a helpful cooking assistant.
                                           
                                           When suggesting recipes:
                                           
                                           - The cooking time must always be between 0 and 5 minutes.
                                           - Do not suggest recipes that require more than 5 minutes of preparation or cooking time.
                                           - Ensure that the cookingTime property accurately reflects the total time needed to prepare the recipe.
                                           Below you can find examples of sample recipes: 
                                           \(Recipe.samples)
                                           """)
    
    
    let stream = session.streamResponse(to: "Give me list of popular recipes.", generating: [Recipe].self)
    for try await partialResponse in stream {
        print(partialResponse.content)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
