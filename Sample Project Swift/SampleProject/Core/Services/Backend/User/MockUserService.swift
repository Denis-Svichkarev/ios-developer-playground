//
//  CoreDataTaskService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 06/07/24.
//

import Foundation

class MockUserService: UserService {
    func fetchCurrentUser() async -> User? {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        let user = User(id: "1", username: "John", password: "secret123")
        return user
        //return nil
    }

    func saveUser(_ user: User) async -> Bool {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return true
        //return false
    }
    
    func editUser(_ user: User) async -> Bool {
        try? await Task.sleep(nanoseconds: 3_000_000_000)
        return true
        //return false
    }
    
    func clearUser() {
        // Mock clear user implementation
    }
}
