//
//  StorageServiceProtocol.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

protocol StorageServiceProtocol {
    func getFavoriteRecipes() -> [Recipe]
    func toggleFavorite(_ recipe: Recipe) -> Bool
    func saveRecipe(_ recipe: Recipe) throws
}
