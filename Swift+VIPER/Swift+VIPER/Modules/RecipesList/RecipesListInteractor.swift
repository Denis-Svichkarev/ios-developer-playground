//
//  RecipesListInteractor.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

final class RecipesListInteractor: RecipesListInteractorProtocol {
    weak var presenter: RecipesListPresenterProtocol?
    
    func fetchRecipes(for category: Category) async throws -> [Recipe] {
        return [
            Recipe(id: "1", name: "Recipe 1", category: category),
            Recipe(id: "2", name: "Recipe 2", category: category),
            Recipe(id: "3", name: "Recipe 3", category: category)
        ]
    }
}
