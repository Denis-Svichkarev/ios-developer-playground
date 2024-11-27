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
    
    // MARK: - Initialization
    init(category: FurnitureCategory) {
        self.category = category
        self.items = [
            FurnitureItem(
                id: "1",
                name: "Modern Chair",
                description: "Comfortable modern chair",
                category: category,
                price: 299,
                dimensions: Dimensions(width: 0.6, height: 1.0, depth: 0.6),
                modelFileName: "chair_model",
                previewImageName: "chair_preview"
            ),
            FurnitureItem(
                id: "2",
                name: "Classic Chair",
                description: "Classic style chair",
                category: category,
                price: 399,
                dimensions: Dimensions(width: 0.6, height: 1.0, depth: 0.6),
                modelFileName: "chair_model2",
                previewImageName: "chair_preview2"
            )
        ]
    }
}
