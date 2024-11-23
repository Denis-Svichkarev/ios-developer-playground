//
//  UserService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

import Foundation

protocol UserFetchingService {
    func fetchCurrentUser() async -> User?
}

protocol UserSavingService {
    func saveUser(_ user: User) async -> Bool
    func editUser(_ user: User) async -> Bool
}

protocol UserClearService {
    func clearUser()
}

typealias UserService = UserFetchingService & UserSavingService & UserClearService
