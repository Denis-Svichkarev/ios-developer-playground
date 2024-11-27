//
//  FurnitureItem.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import Foundation

struct FurnitureItem {
    let id: String
    let name: String
    let description: String
    let category: FurnitureCategory
    let price: Decimal
    let dimensions: Dimensions
    let modelFileName: String
    let previewImageName: String
}

struct Dimensions {
    let width: Float
    let height: Float
    let depth: Float
}

enum FurnitureCategory: CaseIterable {
    case chair
    case table
    case sofa
    case bed
    case storage
    
    var displayName: String {
        switch self {
            case .chair: return "Chairs"
            case .table: return "Tables"
            case .sofa: return "Sofas"
            case .bed: return "Beds"
            case .storage: return "Storage"
        }
    }
    
    var iconName: String {
        switch self {
            case .chair: return "chair.fill"
            case .table: return "tablecells.fill"
            case .sofa: return "sofa.fill"
            case .bed: return "bed.double.fill"
            case .storage: return "archivebox.fill"
        }
    }
}
