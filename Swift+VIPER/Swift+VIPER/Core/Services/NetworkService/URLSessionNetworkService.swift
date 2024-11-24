//
//  URLSessionNetworkService.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import Foundation

final class URLSessionNetworkService: NetworkServiceProtocol {
    func fetchCategories() async throws -> [Category] {
        var categories: [Category] = [
            Category(id: "1", name: "Breakfast", imageURL: nil, recipesCount: 3),
            Category(id: "2", name: "Lunch", imageURL: nil, recipesCount: 5),
            Category(id: "3", name: "Dinner", imageURL: nil, recipesCount: 2)
        ]
        
        for index in categories.indices {
            categories[index].imageURL = try await ImageURLGenerator.generateRandomImageURL()
        }
        
        return categories
    }
    
    func fetchRecipes(for category: Category) async throws -> [Recipe] {
        return []
    }
    
    func fetchRecipeDetails(id: String) async throws -> Recipe? {
        return nil
    }
    
    func uploadRecipe(_ recipe: Recipe) async throws {
        
    }
}
