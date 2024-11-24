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
        print("Navigate to recipes list for \(category.name)")
    }
}
