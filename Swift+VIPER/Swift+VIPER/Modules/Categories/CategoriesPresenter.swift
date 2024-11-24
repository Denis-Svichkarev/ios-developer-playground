//
//  CategoriesPresenter.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

final class CategoriesPresenter: CategoriesPresenterProtocol {
    weak var view: CategoriesViewProtocol?
    var interactor: CategoriesInteractorProtocol?
    var router: CategoriesRouterProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        Task {
            do {
                let categories = try await interactor?.fetchCategories() ?? []
                await MainActor.run {
                    view?.hideLoading()
                    view?.showCategories(categories)
                }
            } catch {
                await MainActor.run {
                    view?.hideLoading()
                    view?.showError(error)
                }
            }
        }
    }
    
    func didSelectCategory(_ category: Category) {
        router?.showRecipesList(for: category)
    }
}
