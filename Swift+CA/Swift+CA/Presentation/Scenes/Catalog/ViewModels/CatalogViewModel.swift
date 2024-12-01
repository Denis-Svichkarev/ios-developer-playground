//
//  CatalogViewModel.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

final class CatalogViewModel {
    // MARK: - Properties
    private var furnitureItems: [FurnitureItem] = []
    
    // MARK: - Public Methods
    func loadFurniture() async {
        // TODO: Implement loading furniture from repository
    }
    
    func getFurniture(for category: FurnitureCategory) -> [FurnitureItem] {
        return furnitureItems.filter { $0.category == category }
    }
}
