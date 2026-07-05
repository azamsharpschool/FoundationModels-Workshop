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
    @Query private var savedRecipes: [RecipeModel]
    @State private var isLoading: Bool = false
    
    private func saveRecipe(_ recipe: Recipe.PartiallyGenerated) {
        // save recipe to SwiftData store
    }

    private func isSaved(_ recipe: Recipe.PartiallyGenerated) -> Bool {
        guard let name = recipe.name else { return false }
        return savedRecipes.contains { $0.name == name }
    }
    
    var body: some View {
        Text("Recipe List will be displayed here")
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
                
                // call recipeRecommender here
                
                
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


