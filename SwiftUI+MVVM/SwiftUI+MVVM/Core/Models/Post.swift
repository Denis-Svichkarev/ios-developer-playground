//
//  Post.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Foundation

struct Post: Codable, Identifiable {
    var id: UUID
    var userId: UUID
    var content: String
    var timestamp: Date
}
