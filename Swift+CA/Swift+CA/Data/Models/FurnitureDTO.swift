//
//  FurnitureDTO.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import Foundation

struct FurnitureDTO: Codable {
    let id: String
    let name: String
    let description: String
    let categoryId: String
    let price: Decimal
    let dimensions: DimensionsDTO
    let modelFileName: String
    let previewImageName: String
}

struct DimensionsDTO: Codable {
    let width: Float
    let height: Float
    let depth: Float
}

extension FurnitureDTO {
    func toDomain(category: FurnitureCategory) -> FurnitureItem {
        return FurnitureItem(
            id: id,
            name: name,
            description: description,
            category: category,
            price: price,
            dimensions: Dimensions(
                width: dimensions.width,
                height: dimensions.height,
                depth: dimensions.depth
            ),
            modelFileName: modelFileName,
            previewImageName: previewImageName
        )
    }
}
