//
//  MockFriendService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

class MockFriendService: FriendFetchingService {
    func fetchFriends(for user: User, completion: @escaping ([User]?) -> Void) {
        let delay = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: delay) {
            let mockFriends = [
                User(id: "2", username: "MockFriend1", password: "password"),
                User(id: "3", username: "MockFriend2", password: "password")
            ]
            completion(mockFriends)
        }
    }
}
