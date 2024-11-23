//
//  AuthViewModel.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 14/07/24.
//

import Foundation

protocol LoginViewModelDelegate: AnyObject {
    func validationSuccess(username: String, password: String)
    func validationFailed()
}

class LoginViewModel {
    private let localizationService: LocalizableServiceProtocol
    
    var username: String?
    var password: String?
    
    weak var delegate: LoginViewModelDelegate?
       
    init(localizationService: LocalizableServiceProtocol) {
        self.localizationService = localizationService
    }
    
    var screenTitle: String {
        return localizationService.localizedString(forKey: "login_screen_title", tableName: "AuthLocalizable")
    }
    
    var usernamePlaceholder: String {
        return localizationService.localizedString(forKey: "login_username_placeholder", tableName: "AuthLocalizable")
    }
    
    var passwordPlaceholder: String {
        return localizationService.localizedString(forKey: "login_password_placeholder", tableName: "AuthLocalizable")
    }
    
    var loginButtonTitle: String {
        return localizationService.localizedString(forKey: "login_button_title", tableName: "AuthLocalizable")
    }
    
    var registerButtonTitle: String {
        return localizationService.localizedString(forKey: "register_button_title", tableName: "AuthLocalizable")
    }
    
    func login() {
        guard let username = username, let password = password else {
            delegate?.validationFailed()
            return
        }
        
        if validateInput(username: username, password: password) {
            delegate?.validationSuccess(username: username, password: password)
        } else {
            delegate?.validationFailed()
        }
    }
        
    func validateInput(username: String, password: String) -> Bool {
        return !username.isEmpty && !password.isEmpty
    }
}
