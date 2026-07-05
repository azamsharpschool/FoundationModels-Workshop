//
//  RecipeDetailScreen.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/28/26.
//

import SwiftUI
import FoundationModels

struct RecipeDetailScreen: View {
    
    let recipe: Recipe.PartiallyGenerated
    @State private var recipeSteps: [RecipeStep.PartiallyGenerated] = []
    @Environment(RecipeRecommender.self) private var recipeRecommender
    
    private func loadRecipeSteps() async {
        do {
            recipeSteps.removeAll()
            let stream = recipeRecommender.streamSteps(for: recipe)
            for try await partialResponse in stream {
                recipeSteps = partialResponse.content
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        List(recipeSteps) { recipeStep in
            Text(recipeStep.instructions ?? "")
        }
        .task {
            await loadRecipeSteps()
        }
    }
}

