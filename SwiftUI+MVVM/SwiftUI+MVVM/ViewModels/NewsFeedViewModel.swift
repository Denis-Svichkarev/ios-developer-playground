//
//  NewsFeedViewModel.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

class NewsFeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    func fetchPosts() {
        // Логика для получения постов (например, из API)
    }
}
