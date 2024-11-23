//
//  AuthViewModel.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    
    var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    init(userService: UserServiceProtocol = DataSourceManager.shared.getUserService()) {
        self.userService = userService
    }
    
    @MainActor
    func login() async throws -> User {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let user = try await userService.login(email: email, password: password)
            errorMessage = nil
            return user
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
}
