//
//  AppCoordinator.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import UIKit

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showCatalog()
    }
    
    private func showCatalog() {
        let catalogViewModel = CatalogViewModel()
        let catalogVC = CatalogViewController(viewModel: catalogViewModel)
        catalogVC.coordinator = self
        navigationController.pushViewController(catalogVC, animated: false)
    }
    
    func showCategoryDetail(category: FurnitureCategory) {
        let detailViewModel = CategoryDetailViewModel(category: category)
        let detailVC = CategoryDetailViewController(viewModel: detailViewModel)
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
}
