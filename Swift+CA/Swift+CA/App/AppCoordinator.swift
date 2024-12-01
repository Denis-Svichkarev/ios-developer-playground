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
        let dataSource = LocalFurnitureDataSource()
        let repository = FurnitureRepositoryImpl(dataSource: dataSource)
        let useCase = GetCategoryFurnitureUseCaseImpl(repository: repository)
        let viewModel = CategoryDetailViewModel(
            category: category,
            getCategoryFurniture: useCase
        )
        let detailVC = CategoryDetailViewController(viewModel: viewModel)
        detailVC.coordinator = self
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func showAR(for item: FurnitureItem) {
        let viewModel = ARViewModel(furnitureItem: item)
        let arVC = ARViewController(viewModel: viewModel)
        arVC.coordinator = self
        navigationController.pushViewController(arVC, animated: true)
    }
    
    func dismissAR() {
        navigationController.popViewController(animated: true)
    }
}
