//
//  RecipesListPresenter.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

final class RecipesListPresenter: RecipesListPresenterProtocol {
    weak var view: RecipesListViewProtocol?
    var interactor: RecipesListInteractorProtocol?
    var router: RecipesListRouterProtocol?
    
    private let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    func viewDidLoad() {
        view?.showLoading()
        Task {
            do {
                let recipes = try await interactor?.fetchRecipes(for: category) ?? []
                await MainActor.run {
                    view?.hideLoading()
                    view?.showRecipes(recipes)
                }
            } catch {
                await MainActor.run {
                    view?.hideLoading()
                    view?.showError(error)
                }
            }
        }
    }
    
    func didSelectRecipe(_ recipe: Recipe) {
        router?.showRecipeDetail(for: recipe)
    }
}
