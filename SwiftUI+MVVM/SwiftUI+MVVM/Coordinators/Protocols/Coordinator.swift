//
//  Coordinator.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

protocol Coordinator: ObservableObject {
    var navigationStack: [Route] { get set }
    func navigate(to route: Route)
    func pop()
    func popToRoot()
}
