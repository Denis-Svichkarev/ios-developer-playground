//
//  AuthCoordinator.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

import UIKit

class AuthCoordinator: Coordinator {
    var window: UIWindow
    var navigationVC: UINavigationController!
    var userViewModel: UserViewModel
  
    let userService: UserService = MockUserService()
    
    init(window: UIWindow, userViewModel: UserViewModel) {
        self.window = window
        self.userViewModel = userViewModel
    }

    override func start() {
        let loginVC = LoginViewController(userViewModel: userViewModel)
        loginVC.delegate = self
        navigationVC = UINavigationController(rootViewController: loginVC)
        self.window.rootViewController = navigationVC
    }
    
    private func showRegistration() {
        let registrationVC = RegistrationViewController(userViewModel: userViewModel)
        navigationVC.pushViewController(registrationVC, animated: true)
    }
}

extension AuthCoordinator: LoginViewControllerDelegate {
    func didTapRegisterButton() {
        showRegistration()
    }
}
