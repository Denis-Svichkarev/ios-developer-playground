//
//  AppCoordinator.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

@MainActor
class AppCoordinator: ObservableObject {
    @Published private(set) var currentFlow: AppFlow
    @Published var navigationPath: [Route] = []
    @Published private(set) var isInitializing = true
    
    private let userService: UserServiceProtocol
    
    init(
        userService: UserServiceProtocol = DataSourceManager.shared.getUserService()
    ) {
        self.userService = userService
        self.currentFlow = .auth
        
        Task {
            await checkInitialFlow()
        }
    }
    
    // MARK: - Public Methods
        
    func handle(_ action: NavigationAction) {
        switch action {
        // Auth actions
        case .showLogin:
            navigationPath.append(.login)
        case .showRegistration:
            navigationPath.append(.registration)
        case .showForgotPassword:
            navigationPath.append(.forgotPassword)
        case .loginSuccess:
            currentFlow = .main
            navigationPath.removeAll()
        case .logout:
            handleLogout()
            
        // Main flow actions
        case .showPostDetail(let post):
            navigationPath.append(.postDetail(post))
        case .showProfile(let user):
            navigationPath.append(.userProfile(user))
        case .showSettings:
            navigationPath.append(.settings)
        case .createNewPost:
            navigationPath.append(.createNewPost)
            
        // Settings actions
        case .showAccountSettings:
            navigationPath.append(.accountSettings)
        case .showPrivacySettings:
            navigationPath.append(.privacySettings)
        case .showNotificationSettings:
            navigationPath.append(.notificationSettings)
            
        // Profile actions
        case .showEditProfile:
            navigationPath.append(.editProfile)
        case .showMyPosts:
            navigationPath.append(.myPosts)
            
        // Common actions
        case .back:
            if !navigationPath.isEmpty {
                navigationPath.removeLast()
            }
        case .backToRoot:
            navigationPath.removeAll()
        }
    }
    
    // MARK: - Private Methods
        
    private func checkInitialFlow() async {
        do {
            let user = try await userService.login(email: "test@test.com", password: "12345")
            print("Logged in user: \(user.name)")
            currentFlow = .main
        } catch {
            print("Login failed: \(error.localizedDescription)")
            currentFlow = .auth
        }
        isInitializing = false
    }
    
    private func handleLogout() {
        userService.logout()
        navigationPath.removeAll()
        currentFlow = .auth
    }
}
