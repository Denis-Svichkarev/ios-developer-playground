//
//  CategoriesRouter.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

final class CategoriesRouter: CategoriesRouterProtocol {
    weak var viewController: UIViewController?
        
    func showRecipesList(for category: Category) {
        let recipesListViewController = RecipesListModuleBuilder.build(with: category)
        viewController?.navigationController?.pushViewController(recipesListViewController, animated: true)
    }
}
