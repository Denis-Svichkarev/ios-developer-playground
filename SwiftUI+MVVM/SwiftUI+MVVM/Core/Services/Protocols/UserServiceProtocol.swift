//
//  UserServiceProtocol.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine

protocol UserServiceProtocol {
    func login(email: String, password: String) async throws -> User
    func logout()
}
