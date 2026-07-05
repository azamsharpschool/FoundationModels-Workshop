//
//  RecipeRecommender.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import Observation
import FoundationModels

@MainActor
@Observable
class RecipeRecommender {
    
    let session: LanguageModelSession
    var recipes: [Recipe.PartiallyGenerated] = []
    private var suggestedIngredients: Set<Ingredient>?
    
    init(session: LanguageModelSession) {
        self.session = session
    }
    
    func suggestRecipes(ingredients: Set<Ingredient>) async throws {
        
        guard suggestedIngredients != ingredients || recipes.isEmpty else { return }
        
        suggestedIngredients = ingredients
        recipes.removeAll()
        
        let prompt = "Suggest 8-10 recipes based on the following ingredient(s): \n \(ingredients.map(\.name).joined(separator: ", "))"
        
        let stream = session.streamResponse(to: prompt, generating: [Recipe].self)
        for try await partialResponse in stream {
            recipes = partialResponse.content
        }
    }
    
    func streamSteps(for recipe: Recipe.PartiallyGenerated) -> LanguageModelSession.ResponseStream<[RecipeStep]> {
        let prompt = "Generate 8-10 steps to cook \(recipe.name ?? "")."
        return session.streamResponse(to: prompt, generating: [RecipeStep].self)
    }
    
    /*
    func buildSteps(recipe: Recipe.PartiallyGenerated) async throws -> [RecipeStep.PartiallyGenerated] {
        
        var steps: [RecipeStep.PartiallyGenerated] = []
        let prompt = "Generate 8-10 steps to cook \(recipe.name ?? "")."
        
        let stream = session.streamResponse(to: prompt, generating: [RecipeStep].self)
        for try await partialResponse in stream {
            steps = partialResponse.content
        }
        
        return steps
    } */
    
}
