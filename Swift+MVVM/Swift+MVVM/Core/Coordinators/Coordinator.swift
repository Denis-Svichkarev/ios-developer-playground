//
//  Coordinator.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 10.07.2024.
//

import Foundation

class Coordinator {
    var childCoordinators: [Coordinator] = []

    func start() {
        // Override in subclasses to start coordinating
    }

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    func didFinish(childCoordinator: Coordinator) {
        removeChildCoordinator(childCoordinator)
    }
}
