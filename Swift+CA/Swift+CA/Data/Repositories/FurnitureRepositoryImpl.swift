//
//  FurnitureRepositoryImpl.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

final class FurnitureRepositoryImpl: FurnitureRepository {
    private let dataSource: FurnitureDataSource
    
    init(dataSource: FurnitureDataSource) {
        self.dataSource = dataSource
    }
    
    func getFurniture(by category: FurnitureCategory) async throws -> [FurnitureItem] {
        let dtoItems = try await dataSource.getFurniture(by: category)
        return dtoItems.map { $0.toDomain(category: category) }
    }
    
    func getFurnitureDetails(by id: String) async throws -> FurnitureItem {
        let dto = try await dataSource.getFurnitureDetails(by: id)
        let category = FurnitureCategory.fromString(dto.categoryId)
        return dto.toDomain(category: category)
    }
    
    func searchFurniture(query: String, category: FurnitureCategory?) async throws -> [FurnitureItem] {
        return []
    }
}
