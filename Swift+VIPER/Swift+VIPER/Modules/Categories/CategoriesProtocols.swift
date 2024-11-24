//
//  CategoriesViewProtocol.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

protocol CategoriesViewProtocol: AnyObject {
    func showCategories(_ categories: [Category])
    func showLoading()
    func hideLoading()
    func showError(_ error: Error)
}

protocol CategoriesPresenterProtocol: AnyObject {
    var view: CategoriesViewProtocol? { get set }
    var interactor: CategoriesInteractorProtocol? { get set }
    var router: CategoriesRouterProtocol? { get set }
    
    func viewDidLoad()
    func didSelectCategory(_ category: Category)
}

protocol CategoriesInteractorProtocol: AnyObject {
    var presenter: CategoriesPresenterProtocol? { get set }
    func fetchCategories() async throws -> [Category]
}

protocol CategoriesRouterProtocol: AnyObject {
    var viewController: UIViewController? { get set }
    func showRecipesList(for category: Category)
}
