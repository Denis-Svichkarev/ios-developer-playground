//
//  FriendFetchingService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

protocol FriendFetchingService {
    func fetchFriends(for user: User, completion: @escaping ([User]?) -> Void)
}
