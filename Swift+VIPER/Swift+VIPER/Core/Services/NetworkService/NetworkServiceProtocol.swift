//
//  NetworkServiceProtocol.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

protocol NetworkServiceProtocol {
    func fetchCategories() async throws -> [Category]
    func fetchRecipes(for category: Category) async throws -> [Recipe]
    func fetchRecipeDetails(id: String) async throws -> Recipe?
    func uploadRecipe(_ recipe: Recipe) async throws
}
