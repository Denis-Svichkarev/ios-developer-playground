//
//  UserViewModel.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 21/11/24.
//

import Combine

class UserViewModel: ObservableObject {
    @Published var user: User?
    
    func downloadUser() {
        user = .init(name: "Denis", age: 30)
    }
    
    func changeName(name: String) {
        user?.name = name
    }
    
    func changeAge(age: Int) {
        user?.age = age
    }
}
