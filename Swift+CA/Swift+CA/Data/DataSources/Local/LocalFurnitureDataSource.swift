//
//  LocalFurnitureDataSource.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import Foundation

protocol FurnitureDataSource {
    func getFurniture(by category: FurnitureCategory) async throws -> [FurnitureDTO]
    func getFurnitureDetails(by id: String) async throws -> FurnitureDTO
}

final class LocalFurnitureDataSource: FurnitureDataSource {
    private let mockData: [FurnitureDTO] = [
        FurnitureDTO(
            id: "chair1",
            name: "Old Chair",
            description: "Comfortable modern chair",
            categoryId: "chair",
            price: 99,
            dimensions: DimensionsDTO(width: 0.6, height: 1.0, depth: 0.6),
            modelFileName: "chair_model",
            previewImageName: "chair_preview"
        ),
        FurnitureDTO(
            id: "chair2",
            name: "Modern Chair",
            description: "Very old chair",
            categoryId: "chair",
            price: 299,
            dimensions: DimensionsDTO(width: 0.6, height: 1.0, depth: 0.6),
            modelFileName: "chair_model",
            previewImageName: "chair_preview"
        ),
    ]
    
    func getFurniture(by category: FurnitureCategory) async throws -> [FurnitureDTO] {
        return mockData.filter { $0.categoryId == category.rawValue }
    }
    
    func getFurnitureDetails(by id: String) async throws -> FurnitureDTO {
        guard let item = mockData.first(where: { $0.id == id }) else {
            throw NSError(domain: "FurnitureError", code: 404)
        }
        return item
    }
}
