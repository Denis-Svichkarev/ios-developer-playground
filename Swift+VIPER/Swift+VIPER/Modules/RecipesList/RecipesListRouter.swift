//
//  RecipesListRouter.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

final class RecipesListRouter: RecipesListRouterProtocol {
    weak var viewController: UIViewController?
    
    func showRecipeDetail(for recipe: Recipe) {
        print("Navigate to recipe detail for \(recipe.name)")
    }
}
