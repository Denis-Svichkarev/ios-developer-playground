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
    
    private init() {}
    
    func getUserService() -> UserServiceProtocol {
        return UserService(isFakeData: isFakeData)
    }
}
