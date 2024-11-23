//
//  NewsFeedFetchingService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

protocol PostFetchingService {
    func fetchPosts(for user: User, completion: @escaping ([Post]?) -> Void)
}
