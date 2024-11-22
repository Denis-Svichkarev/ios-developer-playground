//
//  AppCoordinator.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

class AppCoordinator: Coordinator {
    @Published var navigationStack: [Route] = [.loading]
    
    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = DataSourceManager.shared.getUserService()) {
        self.userService = userService
        checkUserStatus()
    }
    
    func navigate(to route: Route) {
        navigationStack.append(route)
    }
    
    func pop() {
        navigationStack.removeLast()
    }
    
    func popToRoot() {
        navigationStack.removeAll()
        navigationStack.append(.loading)
    }
    
    func logout() {
        userService.logout()
        popToRoot()
        navigate(to: .auth)
    }

    private func checkUserStatus() {
        userService.login(email: "test@test.com", password: "12345")
            .sink { completion in
                switch completion {
                case .finished:
                    print("Login successful")
                    self.navigate(to: .newsFeed)
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                    self.navigate(to: .auth)
                }
                self.navigationStack.removeFirst()
                
            } receiveValue: { user in
                print("Logged in user: \(user.name)")
            }
            .store(in: &cancellables)
    }
}
