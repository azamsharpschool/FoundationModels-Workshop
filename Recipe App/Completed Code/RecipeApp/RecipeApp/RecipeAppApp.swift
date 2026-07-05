//
//  RecipeApp_IntegrationFMApp.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import SwiftUI
import SwiftData
import FoundationModels

enum Prompts {

    static var recipeAssistant: String {
        """
        You are a helpful cooking assistant for an app that recommends recipes from ingredients selected by the user.

        When suggesting recipes:

        - Base every recipe primarily on the selected ingredients provided in the prompt.
        - Prefer recipes that use multiple selected ingredients together.
        - You may assume common pantry staples such as salt, pepper, water, and cooking oil.
        - Do not require major ingredients that were not selected by the user.
        - Suggest recipes that can be prepared and cooked in 5 minutes or less.
        - Ensure that the cookingTime property accurately reflects the total time needed to prepare and cook the recipe.

        Below are examples of valid recipes:
        \(Recipe.samples)
        """
    }
}

private struct AvailableRecipeAppView: View {
    @State private var recipeRecommender = RecipeRecommender(
        session: LanguageModelSession(instructions: Prompts.recipeAssistant)
    )
    
    var body: some View {
        IngredientListScreen()
            .environment(recipeRecommender)
            .modelContainer(for: RecipeModel.self)
    }
}

@main
struct RecipeAppApp: App {
    
    private let model = SystemLanguageModel.default
    
    var body: some Scene {
        WindowGroup {
            switch model.availability {
            case .available:
                AvailableRecipeAppView()
            case .unavailable(.deviceNotEligible):
                PopularRecipeListScreen()
            case .unavailable(.appleIntelligenceNotEnabled):
                ContentUnavailableView(
                    "Apple Intelligence Off",
                    systemImage: "gear",
                    description: Text("Turn on Apple Intelligence in Settings to generate recipes.")
                )
            case .unavailable(.modelNotReady):
                ContentUnavailableView(
                    "Model Not Ready",
                    systemImage: "hourglass",
                    description: Text("Apple Intelligence is still downloading or preparing. Try again later.")
                )
            case .unavailable(let reason):
                ContentUnavailableView(
                    "Recipe Suggestions Unavailable",
                    systemImage: "exclamationmark.triangle",
                    description: Text("Recipe suggestions are not available right now. Reason: \(String(describing: reason))")
                )
            }
        }
    }
}
