//
//  Post.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

struct Post {
    let id: String
    let author: User
    let content: String
    let timestamp: Date
    let imageUrl: URL?
}
