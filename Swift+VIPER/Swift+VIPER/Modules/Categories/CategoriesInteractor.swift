//
//  CategoriesInteractor.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

final class CategoriesInteractor: CategoriesInteractorProtocol {
    weak var presenter: CategoriesPresenterProtocol?
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCategories() async throws -> [Category] {
        let categories = try await networkService.fetchCategories()
             return categories
    }
}
