//
//  Models.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import Foundation
import SwiftData

@Model
class RecipeModel {
    var id: UUID
    var name: String
    var recipeDescription: String
    var cookingTime: Int?
    var createdAt: Date

    @Relationship(deleteRule: .cascade)
    var cuisine: CuisineModel?

    @Relationship(deleteRule: .cascade)
    var ingredients: [IngredientModel]

    @Relationship(deleteRule: .cascade)
    var steps: [RecipeStepModel]

    init(
        id: UUID = UUID(),
        name: String,
        recipeDescription: String,
        cookingTime: Int? = nil,
        cuisine: CuisineModel? = nil,
        ingredients: [IngredientModel] = [],
        steps: [RecipeStepModel] = [],
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.recipeDescription = recipeDescription
        self.cookingTime = cookingTime
        self.cuisine = cuisine
        self.ingredients = ingredients
        self.steps = steps
        self.createdAt = createdAt
    }

    convenience init(recipe: Recipe.PartiallyGenerated, ingredients: Set<Ingredient> = []) {
        let ingredientModels = ingredients
            .map { IngredientModel(ingredient: $0) }
            .sorted { $0.name < $1.name }

        self.init(
            name: recipe.name ?? "Untitled Recipe",
            recipeDescription: recipe.description ?? "",
            cookingTime: recipe.cookingTime,
            cuisine: CuisineModel(value: recipe.cuisine),
            ingredients: ingredientModels
            //steps: recipe.steps?.map { RecipeStepModel(step: $0) } ?? []
        )
    }
}

@Model
class IngredientModel {
    var id: UUID
    var name: String
    var quantity: Double

    @Relationship(deleteRule: .cascade)
    var unit: UnitModel

    init(id: UUID = UUID(), name: String, quantity: Double, unit: UnitModel) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.unit = unit
    }

    convenience init(ingredient: Ingredient) {
        self.init(
            name: ingredient.name,
            quantity: ingredient.quantity,
            unit: UnitModel(unit: ingredient.unit)
        )
    }
}

@Model
class CuisineModel {
    var id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }

    convenience init?<Value>(value: Value?) {
        guard let value else { return nil }
        self.init(name: String(describing: value))
    }
}

@Model
class RecipeStepModel {
    var id: UUID
    var order: Int
    var instruction: String
    var duration: Int
    var note: String?

    init(
        id: UUID = UUID(),
        order: Int,
        instruction: String,
        duration: Int,
        note: String? = nil
    ) {
        self.id = id
        self.order = order
        self.instruction = instruction
        self.duration = duration
        self.note = note
    }

    convenience init(step: RecipeStep.PartiallyGenerated) {
        self.init(
            order: step.order ?? 0,
            instruction: step.instructions ?? "",
            duration: step.duration ?? 0,
            note: step.note
        )
    }
}

@Model
class UnitModel {
    var id: UUID
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }

    convenience init(unit: Unit) {
        self.init(name: unit.rawValue)
    }
}
