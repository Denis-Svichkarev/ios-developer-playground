//
//  RecipesListProtocols.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

protocol RecipesListViewProtocol: AnyObject {
    func showRecipes(_ recipes: [Recipe])
    func showLoading()
    func hideLoading()
    func showError(_ error: Error)
}

protocol RecipesListPresenterProtocol: AnyObject {
    var view: RecipesListViewProtocol? { get set }
    var interactor: RecipesListInteractorProtocol? { get set }
    var router: RecipesListRouterProtocol? { get set }
    
    func viewDidLoad()
    func didSelectRecipe(_ recipe: Recipe)
}

protocol RecipesListInteractorProtocol: AnyObject {
    var presenter: RecipesListPresenterProtocol? { get set }
    func fetchRecipes(for category: Category) async throws -> [Recipe]
}

protocol RecipesListRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showRecipeDetail(for recipe: Recipe)
}
