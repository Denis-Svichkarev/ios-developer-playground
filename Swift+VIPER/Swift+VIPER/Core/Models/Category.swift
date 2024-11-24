//
//  Category.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

struct Category: Codable {
    let id: String
    let name: String
    var imageURL: String?
    let recipesCount: Int
}
