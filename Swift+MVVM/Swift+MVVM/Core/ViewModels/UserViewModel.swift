//
//  AuthViewModel.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

import Combine

class UserViewModel {
    private let userService: UserService
    private var cancellables = Set<AnyCancellable>()

    @Published var user: User? = nil
    @Published var isLoading: Bool = false
    
    var userDidChange: ((User?) -> Void)?

    init(userService: UserService) {
        self.userService = userService
    }

    func fetchCurrentUser() async {
        isLoading = true
        self.user = await userService.fetchCurrentUser()
        isLoading = false
    }

    func saveUser(username: String, password: String) async {
        let user = User(username: username, password: password)
        let success = await userService.saveUser(user)
        self.user = success ? user : nil
    }

    func clearUser() {
        userService.clearUser()
        user = nil
    }
}
