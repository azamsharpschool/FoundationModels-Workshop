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

@main
struct RecipeAppApp: App {
    
    private var container: ModelContainer
    private let model = SystemLanguageModel.default
    
    init() {
        // initialize the model container for SwiftData
        container = try! ModelContainer(for: RecipeModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
    }
    
    var body: some Scene {
        WindowGroup {
            
            // need to add a check to make sure to display the correct view
            // based on the availability of the Apple Intelligence feature
            
            
            IngredientListScreen()
                .modelContainer(container)
                
        }
    }
}
