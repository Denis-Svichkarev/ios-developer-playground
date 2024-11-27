//
//  CategoryDetailViewModel.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

final class CategoryDetailViewModel {
    // MARK: - Properties
    let category: FurnitureCategory
    private(set) var items: [FurnitureItem] = []
    private let getCategoryFurniture: GetCategoryFurnitureUseCase
    
    // MARK: - Initialization
    init(
        category: FurnitureCategory,
        getCategoryFurniture: GetCategoryFurnitureUseCase
    ) {
        self.category = category
        self.getCategoryFurniture = getCategoryFurniture
    }
    
    // MARK: - Public Methods
    func loadFurniture() async throws {
        items = try await getCategoryFurniture.execute(category: category)
    }
}
