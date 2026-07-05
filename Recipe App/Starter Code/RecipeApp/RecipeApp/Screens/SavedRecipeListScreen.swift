//
//  SavedRecipeListScreen.swift
//  RecipeApp-IntegrationFM
//
//  Created by Mohammad Azam on 6/26/26.
//

import SwiftData
import SwiftUI

struct SavedRecipeListScreen: View {
    @Query(sort: \RecipeModel.createdAt, order: .reverse) private var recipes: [RecipeModel]

    var body: some View {
        List(recipes) { recipe in
            Text(recipe.name)
        }
        .navigationTitle("Saved Recipes")
    }
}
