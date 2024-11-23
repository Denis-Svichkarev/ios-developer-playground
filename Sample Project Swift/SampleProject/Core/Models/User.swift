//
//  User.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 29/06/24.
//

struct User {
    let id: String?
    let username: String
    let password: String
    
    init(id: String? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
