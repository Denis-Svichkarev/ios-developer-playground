//
//  HomeCoordinator.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

import UIKit

class HomeCoordinator: Coordinator {
    var window: UIWindow
    var userViewModel: UserViewModel
    var homeVC: HomeViewController!
    
    let userService: UserService = MockUserService()
    
    init(window: UIWindow, userViewModel: UserViewModel) {
        self.window = window
        self.userViewModel = userViewModel
    }

    override func start() {
        homeVC = HomeViewController(userViewModel: userViewModel)
        self.window.rootViewController = UINavigationController(rootViewController: homeVC)
    }
}
