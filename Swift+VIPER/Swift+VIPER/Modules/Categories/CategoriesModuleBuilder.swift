//
//  CategoriesAssembly.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import UIKit

final class CategoriesModuleBuilder {
    static func build() -> UIViewController {
        let view = CategoriesViewController()
        let interactor = CategoriesInteractor()
        let router = CategoriesRouter()
        let presenter = CategoriesPresenter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
