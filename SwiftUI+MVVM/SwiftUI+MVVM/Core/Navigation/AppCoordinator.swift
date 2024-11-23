//
//  AppCoordinator.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

class AppCoordinator: ObservableObject {
    @Published var path: [Route] = []
    @Published private(set) var isInitializing = true
    
    private let userService: UserServiceProtocol
    private let userState: UserState
    
    init(
        userService: UserServiceProtocol = DataSourceManager.shared.getUserService(),
        userState: UserState = DataSourceManager.shared.getUserState()
    ) {
        self.userService = userService
        self.userState = userState
        checkUserStatus()
    }
    
    func logout() {
        userService.logout()
    }
    
    private func checkUserStatus() {
        Task {
            do {
                let user = try await userService.login(email: "test@test.com", password: "12345")
                print("Logged in user: \(user.name)")
            } catch {
                print("Login failed: \(error.localizedDescription)")
            }
            isInitializing = false
        }
    }
}
