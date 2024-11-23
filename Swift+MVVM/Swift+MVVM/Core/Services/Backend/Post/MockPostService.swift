//
//  MockPostService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

class MockPostService: PostFetchingService {
    func fetchPosts(for user: User, completion: @escaping ([Post]?) -> Void) {
        let delay = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            let mockPosts = [
                Post(id: "1", author: user, content: "This is a mock post", timestamp: Date(), imageUrl: nil),
                Post(id: "2", author: user, content: "Another mock post", timestamp: Date(), imageUrl: URL(string: "https://example.com/image.png"))
            ]
            completion(mockPosts)
        }
    }
}
