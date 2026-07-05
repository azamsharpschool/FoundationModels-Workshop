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
    
    private func loadRecipeSteps() async {
        do {
            // load recipe steps based on the passed recipe
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

