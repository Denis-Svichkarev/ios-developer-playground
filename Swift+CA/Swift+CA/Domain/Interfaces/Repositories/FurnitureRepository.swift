//
//  FurnitureRepository.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

protocol FurnitureRepository {
    func getFurniture(by category: FurnitureCategory) async throws -> [FurnitureItem]
    func getFurnitureDetails(by id: String) async throws -> FurnitureItem
    func searchFurniture(query: String, category: FurnitureCategory?) async throws -> [FurnitureItem]
}
