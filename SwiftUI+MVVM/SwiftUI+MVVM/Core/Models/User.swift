//
//  User.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 21/11/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID
    var name: String
    var age: Int
}
