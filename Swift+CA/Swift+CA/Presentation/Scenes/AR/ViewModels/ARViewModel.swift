//
//  ARViewModel.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 30/11/24.
//

import ARKit
import RealityKit

final class ARViewModel {
    // MARK: - Properties
    let furnitureItem: FurnitureItem
    
    // MARK: - Initialization
    init(furnitureItem: FurnitureItem) {
        self.furnitureItem = furnitureItem
    }
    
    // MARK: - Public Methods
    func loadModel() throws -> ModelEntity {
        let mesh = MeshResource.generateBox(width: 0.3, height: 0.3, depth: 0.3)
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        return ModelEntity(mesh: mesh, materials: [material])
    }
}
