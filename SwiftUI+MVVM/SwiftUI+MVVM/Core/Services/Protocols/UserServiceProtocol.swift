//
//  UserServiceProtocol.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

protocol UserServiceProtocol {
    var currentUser: User? { get }
    var isLoggedIn: Bool { get }
    
    func login(email: String, password: String) -> AnyPublisher<User, UserServiceError>
    func logout()
}
