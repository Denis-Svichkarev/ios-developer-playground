//
//  AuthViewModel.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

class AuthViewModel: ObservableObject {
    @Published var errorMessage: String?
    
    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(userService: UserServiceProtocol) {
        self.userService = userService
    }

    func login(email: String, password: String) {
        userService.login(email: email, password: password)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Login successful")
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                }
            }, receiveValue: { user in
                print("Logged in user: \(user.name)")
            })
            .store(in: &cancellables)
    }
}
