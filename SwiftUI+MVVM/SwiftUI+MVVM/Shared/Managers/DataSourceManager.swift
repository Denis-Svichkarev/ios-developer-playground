//
//  DataSourceManager.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Foundation

class DataSourceManager {
    static let shared = DataSourceManager()
    
    var isFakeData: Bool = true
    
    private let userState: UserState
    private lazy var userService: UserService = {
        UserService(isFakeData: isFakeData, userState: userState)
    }()
    
    private init() {
        self.userState = UserState()
    }
    
    func getUserService() -> UserServiceProtocol {
        userService
    }
    
    func getUserState() -> UserState {
        userState
    }
}
