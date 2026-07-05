//
//  RecipeListScreen.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import SwiftUI
import SwiftData

struct RecipeListScreen: View {
    
    let ingredients: Set<Ingredient>
    @Environment(\.dismiss) private var dismiss
    @Environment(RecipeRecommender.self) private var recipeRecommender
    @Environment(\.modelContext) private var modelContext
    @Query private var savedRecipes: [RecipeModel]
    @State private var isLoading: Bool = false
    
    private func saveRecipe(_ recipe: Recipe.PartiallyGenerated) {
        guard !isSaved(recipe) else { return }

        let recipeModel = RecipeModel(recipe: recipe, ingredients: ingredients)
        modelContext.insert(recipeModel)
    }

    private func isSaved(_ recipe: Recipe.PartiallyGenerated) -> Bool {
        guard let name = recipe.name else { return false }
        return savedRecipes.contains { $0.name == name }
    }
    
    var body: some View {
        List(recipeRecommender.recipes) { recipe in
            NavigationLink {
                RecipeDetailScreen(recipe: recipe)
                    .navigationTitle(recipe.name ?? "")
            } label: {
                RecipeRow(recipe: recipe, isSaved: isSaved(recipe)) {
                    saveRecipe(recipe)
                }
            }
        }
        .navigationTitle("Recipes")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Close") {
                    dismiss()
                }
            }
        }
        .task {
            do {
                isLoading = true
                try await recipeRecommender.suggestRecipes(ingredients: ingredients)
                isLoading = false
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
        }
        .overlay(alignment: .center) {
            if isLoading {
                ZStack {
                    
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    ProgressView("Loading delicious recipes...")
                        .padding()
                        .background(Color(.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                        .shadow(radius: 8)
                }
            }
        }
    }
}

struct RecipeStepListScreen: View {
    
    let recipeSteps: [RecipeStep.PartiallyGenerated]
    
    var body: some View {
        List(recipeSteps) { recipeStep in
            Text(recipeStep.instructions ?? "")
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe.PartiallyGenerated
    let isSaved: Bool
    let onSave: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.name ?? "")
                    .font(.headline)
                Text(recipe.description ?? "")
                HStack {
                    if let cuisine = recipe.cuisine {
                        Text(cuisine.title)
                    }
                    
                    if let cookingTime = recipe.cookingTime {
                        Text("\(cookingTime) min")
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                onSave()
            } label: {
                Image(systemName: isSaved ? "heart.fill" : "heart")
                    .foregroundStyle(isSaved ? .red : .secondary)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isSaved ? "Recipe saved" : "Save recipe")
        }
    }
}

#Preview(traits: .recipeRecommender, .recipeStore) {
    NavigationStack {
        RecipeListScreen(
            ingredients: [
                Ingredient(name: "Eggs", quantity: 2, unit: .pieces),
                Ingredient(name: "Cheddar Cheese", quantity: 1, unit: .cups),
                Ingredient(name: "Spinach", quantity: 1, unit: .cups)
            ]
        )
    }
}

