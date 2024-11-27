//
//  FurnitureRepository.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

protocol FurnitureRepository {
    func getAllFurniture() async throws -> [FurnitureItem]
    func getFurniture(by category: FurnitureCategory) async throws -> [FurnitureItem]
    func getFurnitureItem(by id: String) async throws -> FurnitureItem?
}
