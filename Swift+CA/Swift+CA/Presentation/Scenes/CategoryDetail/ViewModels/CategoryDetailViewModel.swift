//
//  CategoryDetailViewModel.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import Combine

final class CategoryDetailViewModel {
    enum State {
        case idle
        case loading
        case loaded([FurnitureItem])
        case error(String)
    }
   
    // MARK: - Properties
    let category: FurnitureCategory
    private let getCategoryFurniture: GetCategoryFurnitureUseCase
    
    @Published private(set) var state: State = .idle
    
    // MARK: - Initialization
    init(
        category: FurnitureCategory,
        getCategoryFurniture: GetCategoryFurnitureUseCase
    ) {
        self.category = category
        self.getCategoryFurniture = getCategoryFurniture
    }
    
    // MARK: - Public Methods
    func loadFurniture() async {
        state = .loading
        do {
            let items = try await getCategoryFurniture.execute(category: category)
            state = .loaded(items)
        } catch {
            state = .error("Failed to load furniture. Please try again.")
        }
    }
}
