//
//  IngredientListScreen.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import SwiftUI
import SwiftData
import FoundationModels
struct RecipeStorePreviewModifier: PreviewModifier {
    
    static func makeSharedContext() async throws -> ModelContainer {
        let container = try ModelContainer(for: RecipeModel.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content
            .modelContainer(context)
    }
}

struct RecipeRecommenderPreviewModifier: PreviewModifier {
    
    static func makeSharedContext() async throws -> RecipeRecommender {
        
        let session = LanguageModelSession(instructions: """
                                               
                                               You are a helpful cooking assistant.
                                               
                                               When suggesting recipes:
                                               
                                               - The cooking time must always be between 0 and 5 minutes.
                                               - Do not suggest recipes that require more than 5 minutes of preparation or cooking time.
                                               - Ensure that the cookingTime property accurately reflects the total time needed to prepare the recipe.
                                               Below you can find examples of sample recipes: 
                                               \(Recipe.samples)
                                               """)
        return RecipeRecommender(session: session)
    }
    
    func body(content: Content, context: RecipeRecommender) -> some View {
        content
            .environment(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var recipeRecommender: Self {
        .modifier(RecipeRecommenderPreviewModifier())
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    static var recipeStore: Self {
        .modifier(RecipeStorePreviewModifier())
    }
}

struct IngredientListScreen: View {
    @State private var selectedIngredients = Set<Ingredient>()
    @State private var showRecipeListScreen: Bool = false
    @State private var showSavedRecipes: Bool = false

    private let ingredients: [Ingredient] = [
        Ingredient(name: "Chicken Breast", quantity: 2, unit: .pieces),
        Ingredient(name: "Eggs", quantity: 6, unit: .pieces),
        Ingredient(name: "Milk", quantity: 2, unit: .cups),
        Ingredient(name: "Cheddar Cheese", quantity: 1, unit: .cups),
        Ingredient(name: "Butter", quantity: 2, unit: .tablespoons),
        Ingredient(name: "Garlic", quantity: 3, unit: .cloves),
        Ingredient(name: "Onion", quantity: 1, unit: .pieces),
        Ingredient(name: "Tomato", quantity: 2, unit: .pieces),
        Ingredient(name: "Spinach", quantity: 2, unit: .cups),
        Ingredient(name: "Mushrooms", quantity: 1, unit: .cups),
        Ingredient(name: "Bell Pepper", quantity: 1, unit: .pieces),
        Ingredient(name: "Rice", quantity: 1, unit: .cups),
        Ingredient(name: "Pasta", quantity: 200, unit: .grams),
        Ingredient(name: "Bread", quantity: 4, unit: .slices),
        Ingredient(name: "Potato", quantity: 2, unit: .pieces),
        Ingredient(name: "Carrot", quantity: 2, unit: .pieces),
        Ingredient(name: "Avocado", quantity: 1, unit: .pieces),
        Ingredient(name: "Black Beans", quantity: 1, unit: .cups),
        Ingredient(name: "Olive Oil", quantity: 2, unit: .tablespoons),
        Ingredient(name: "Basil", quantity: 1, unit: .cups)
    ]

    var body: some View {
        NavigationStack {
            List(ingredients, id: \.self) { ingredient in
                Button {
                    toggleSelection(for: ingredient)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(ingredient.name)
                                .foregroundStyle(.primary)
                        }

                        Spacer()

                        if selectedIngredients.contains(ingredient) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(.green)
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(.secondary)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .safeAreaInset(edge: .bottom) {
                Button("Suggest Recipes") {
                    showRecipeListScreen = true
                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedIngredients.isEmpty)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.background)
            }
            .navigationTitle("Ingredients")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Show Saved Recipes") {
                        showSavedRecipes = true
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Text("\(selectedIngredients.count) selected")
                        .foregroundStyle(.secondary)
                }
            }
            .sheet(isPresented: $showRecipeListScreen) {
                NavigationStack {
                    RecipeListScreen(ingredients: selectedIngredients)
                }
            }
            .sheet(isPresented: $showSavedRecipes) {
                NavigationStack {
                    SavedRecipeListScreen()
                }
            }
        }
    }

    private func toggleSelection(for ingredient: Ingredient) {
        if selectedIngredients.contains(ingredient) {
            selectedIngredients.remove(ingredient)
        } else {
            selectedIngredients.insert(ingredient)
        }
    }
    
    private func quantityText(for ingredient: Ingredient) -> String {
        let quantity = ingredient.quantity.formatted(.number.precision(.fractionLength(0...2)))
        return "\(quantity) \(ingredient.unit.rawValue)"
    }
}

#Preview(traits: .recipeRecommender, .recipeStore) {
    NavigationStack {
        IngredientListScreen()
    }
}
