//
//  CategoriesInteractor.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

final class CategoriesInteractor: CategoriesInteractorProtocol {
    weak var presenter: CategoriesPresenterProtocol?
       
    func fetchCategories() async throws -> [Category] {
        return [
            Category(id: "1", name: "Breakfast"),
            Category(id: "2", name: "Lunch"),
            Category(id: "3", name: "Dinner")
        ]
    }
}
