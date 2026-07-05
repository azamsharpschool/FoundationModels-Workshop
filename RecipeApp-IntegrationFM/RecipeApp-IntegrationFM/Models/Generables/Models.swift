//
//  Models.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import Foundation
import FoundationModels 

@Generable()
enum Cuisine {
    case italian
    case mexican
    case indian
    case chinese
    case japanese
    case thai
    case american
    case french
    case mediterranean
    
    var title: String {
        switch self {
        case .italian:
            "Italian"
        case .mexican:
            "Mexican"
        case .indian:
            "Indian"
        case .chinese:
            "Chinese"
        case .japanese:
            "Japanese"
        case .thai:
            "Thai"
        case .american:
            "American"
        case .french:
            "French"
        case .mediterranean:
            "Mediterranean"
        }
    }
}

@Generable(description: "A single step in the recipe instructions.")
struct RecipeStep {

    @Guide(description: "The position of this step in the recipe.")
    var order: Int

    @Guide(description: "The instruction for completing this step.")
    var instructions: String

    @Guide(description: "The estimated time in minutes required to complete this step.")
    var duration: Int

    @Guide(description: "Optional tips or notes for this step.")
    var note: String?
}

@Generable(description: "A cooking recipe with details about its name and description.")
struct Recipe {
    @Guide(description: "The name of the recipe.")
    var name: String
    @Guide(description: "A short description of the recipe, including flavor profile and key ingredients.")
    var description: String
    
    @Guide(description: "The cuisine category of the recipe.")
    var cuisine: Cuisine
    @Guide(description: "The cooking time in minutes associated with a recipe", .range(0...5))
    var cookingTime: Int
    
    static var samples: [Recipe] {
            [
                Recipe(
                    name: "Greek Yogurt Berry Bowl",
                    description: "Creamy Greek yogurt topped with fresh berries and honey.",
                    cuisine: .mediterranean,
                    cookingTime: 2
                ),
                Recipe(
                    name: "Avocado Toast",
                    description: "Toasted bread topped with mashed avocado, salt, and pepper.",
                    cuisine: .american,
                    cookingTime: 5
                ),
                Recipe(
                    name: "Caprese Salad",
                    description: "Fresh mozzarella, tomatoes, basil, and olive oil.",
                    cuisine: .italian,
                    cookingTime: 3
                )
            ]
        }
}

@Generable()
struct Ingredient: Hashable {
    @Guide(description: "The name of the ingredient.")
    let name: String

    @Guide(description: "The quantity of the ingredient.")
    let quantity: Double

    @Guide(description: "The unit of measurement for the quantity (e.g., grams, tablespoons, cups).")
    let unit: Unit
}

@Generable()
enum Unit: String, Codable {
    case grams
    case kilograms
    case milliliters
    case liters
    case teaspoons
    case tablespoons
    case cups
    case pieces
    case cloves
    case slices
    case pinch
}
