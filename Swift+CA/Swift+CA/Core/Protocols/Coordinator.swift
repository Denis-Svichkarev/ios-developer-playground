//
//  Coordinator.swift
//  Swift+CA
//
//  Created by Denis Svichkarev on 27/11/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        parentCoordinator?.childCoordinators.removeAll { $0 === self }
    }
}
