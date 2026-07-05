//
//  PopulateRecipeListScreen.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/27/26.
//

import SwiftUI

struct PopularRecipeListScreen: View {
    private let recipes: [PopularRecipe] = [
        PopularRecipe(
            name: "Avocado Toast",
            description: "Toasted sourdough topped with mashed avocado, lemon, chili flakes, and olive oil.",
            cookingTime: 5
        ),
        PopularRecipe(
            name: "Greek Yogurt Berry Bowl",
            description: "Creamy Greek yogurt with mixed berries, honey, and crunchy granola.",
            cookingTime: 3
        ),
        PopularRecipe(
            name: "Caprese Salad",
            description: "Fresh mozzarella, tomatoes, basil, olive oil, and cracked black pepper.",
            cookingTime: 4
        ),
        PopularRecipe(
            name: "Garlic Butter Noodles",
            description: "Warm noodles tossed with garlic butter, parmesan, and parsley.",
            cookingTime: 10
        ),
        PopularRecipe(
            name: "Black Bean Tacos",
            description: "Soft tortillas filled with seasoned black beans, avocado, and salsa.",
            cookingTime: 8
        ),
        PopularRecipe(
            name: "Spinach Mushroom Omelet",
            description: "Fluffy eggs folded with sauteed spinach, mushrooms, and cheddar cheese.",
            cookingTime: 7
        ),
        PopularRecipe(
            name: "Tomato Basil Pasta",
            description: "Pasta tossed with tomatoes, basil, olive oil, and a light sprinkle of cheese.",
            cookingTime: 12
        ),
        PopularRecipe(
            name: "Chicken Rice Bowl",
            description: "Simple rice bowl with chicken, vegetables, and a savory sauce.",
            cookingTime: 15
        )
    ]

    var body: some View {
        List(recipes) { recipe in
            VStack(alignment: .leading, spacing: 6) {
                Text(recipe.name)
                    .font(.headline)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text("\(recipe.cookingTime) min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.vertical, 4)
        }
        .navigationTitle("Popular Recipes")
    }
}

private struct PopularRecipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let cookingTime: Int
}

#Preview {
    NavigationStack {
        PopularRecipeListScreen()
    }
}
