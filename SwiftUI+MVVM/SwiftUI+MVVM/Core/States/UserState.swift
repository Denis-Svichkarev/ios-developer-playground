//
//  UserState.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 23/11/24.
//

import SwiftUI

final class UserState: ObservableObject {
    @Published private(set) var currentUser: User?
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    func updateUser(_ user: User?) {
        currentUser = user
    }
}
