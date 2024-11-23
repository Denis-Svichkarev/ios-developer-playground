//
//  DataService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

class FirebaseUserService: UserService {
    func fetchCurrentUser() async -> User? {
        // Firebase-specific implementation
        return nil
    }

    func saveUser(_ user: User) async -> Bool {
        // Firebase-specific implementation
        return false
    }
    
    func editUser(_ user: User) async -> Bool {
        // Firebase-specific implementation
        return false
    }
    
    func clearUser() {
        // Firebase-specific implementation
    }
}
