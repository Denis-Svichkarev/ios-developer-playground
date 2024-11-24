//
//  RecipesListModuleBuilder.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

final class RecipesListModuleBuilder {
    static func build(with category: Category) -> UIViewController {
        let view = RecipesListViewController()
        let interactor = RecipesListInteractor()
        let router = RecipesListRouter()
        let presenter = RecipesListPresenter(category: category)
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
