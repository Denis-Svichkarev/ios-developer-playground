//
//  GetCategoryFurnitureUseCase.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

protocol GetCategoryFurnitureUseCase {
    func execute(category: FurnitureCategory) async throws -> [FurnitureItem]
}

final class GetCategoryFurnitureUseCaseImpl: GetCategoryFurnitureUseCase {
    private let repository: FurnitureRepository
    
    init(repository: FurnitureRepository) {
        self.repository = repository
    }
    
    func execute(category: FurnitureCategory) async throws -> [FurnitureItem] {
        return try await repository.getFurniture(by: category)
    }
}
