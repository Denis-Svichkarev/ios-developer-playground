//
//  CoreCoordinator.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 07.07.2024.
//

import UIKit
import Combine

class CoreCoordinator: Coordinator {
    var window: UIWindow
    
    var userViewModel: UserViewModel!
    let userService: UserService = MockUserService()
    
    private var cancellables = Set<AnyCancellable>()
    
    init(window: UIWindow) {
        self.window = window
    }

    override func start() {
        userViewModel = UserViewModel(userService: userService)
        bindViewModel()
 
        let loadingViewController = LoadingViewController(nibName: "LoadingViewController", bundle: nil)
        self.window.rootViewController = loadingViewController
        self.window.makeKeyAndVisible()
        
        Task {
            await userViewModel.fetchCurrentUser()
        }
    }
    
    private func bindViewModel() {
        userViewModel.$user
            .sink { [weak self] user in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if user != nil {
                        self.showHome()
                    } else {
                        self.showAuth()
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    private func showHome() {
        if let authCoordinator = childCoordinators.first(where: { $0 is AuthCoordinator }) {
            didFinish(childCoordinator: authCoordinator)
        }
        
        let homeCoordinator = HomeCoordinator(window: window, userViewModel: userViewModel)
        homeCoordinator.start()
        addChildCoordinator(homeCoordinator)
    }
      
    private func showAuth() {
        if let homeCoordinator = childCoordinators.first(where: { $0 is HomeCoordinator }) {
            didFinish(childCoordinator: homeCoordinator)
        }
        
        let authCoordinator = AuthCoordinator(window: window, userViewModel: userViewModel)
        authCoordinator.start()
        addChildCoordinator(authCoordinator)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}
