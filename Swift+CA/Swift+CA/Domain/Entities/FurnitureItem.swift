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

enum FurnitureCategory: String, CaseIterable {
    case chair = "chair"
    case table = "table"
    case sofa = "sofa"
    case bed = "bed"
    case storage = "storage"
    
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
            case .sofa: return "bed.double.fill"
            case .bed: return "bed.double.fill"
            case .storage: return "archivebox.fill"
        }
    }
    
    static func fromString(_ string: String) -> FurnitureCategory {
        switch string.lowercased() {
            case "chair": return .chair
            case "table": return .table
            case "sofa": return .sofa
            case "bed": return .bed
            case "storage": return .storage
            default: return .chair
        }
    }
}
