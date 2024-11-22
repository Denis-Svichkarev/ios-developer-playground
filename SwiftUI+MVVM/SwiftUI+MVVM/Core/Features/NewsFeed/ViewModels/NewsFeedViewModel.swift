//
//  NewsFeedViewModel.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine
import Foundation

class NewsFeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchPosts() {
        posts.append(Post(id: UUID(), userId: UUID(), content: "Post #1", timestamp: Date.now))
        posts.append(Post(id: UUID(), userId: UUID(), content: "Post #2", timestamp: Date.now))
        posts.append(Post(id: UUID(), userId: UUID(), content: "Post #3", timestamp: Date.now))
    }
}
