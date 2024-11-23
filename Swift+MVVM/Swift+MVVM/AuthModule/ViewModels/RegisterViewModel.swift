//
//  RegisterViewModel.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 14/07/24.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func validationSuccess(username: String, password: String)
    func validationFailed()
}

class RegisterViewModel {
    private let localizationService: LocalizableServiceProtocol
    
    var username: String?
    var password: String?
    var confirmPassword: String?
    
    weak var delegate: RegisterViewModelDelegate?
     
    init(localizationService: LocalizableServiceProtocol) {
        self.localizationService = localizationService
    }
    
    var screenTitle: String {
        return localizationService.localizedString(forKey: "registration_screen_title", tableName: "AuthLocalizable")
    }
    
    var usernamePlaceholder: String {
        return localizationService.localizedString(forKey: "registration_username_placeholder", tableName: "AuthLocalizable")
    }
    
    var passwordPlaceholder: String {
        return localizationService.localizedString(forKey: "registration_password_placeholder", tableName: "AuthLocalizable")
    }
    
    var confirmPasswordPlaceholder: String {
        return localizationService.localizedString(forKey: "registration_confirm_password_placeholder", tableName: "AuthLocalizable")
    }
    
    var registerButtonTitle: String {
        return localizationService.localizedString(forKey: "registration_register_button_title", tableName: "AuthLocalizable")
    }
    
    func register() {
        guard let username = username, let password = password, let confirmPassword = confirmPassword else {
            delegate?.validationFailed()
            return
        }
        
        if validateInput(username: username, password: password, confirmPassword: confirmPassword) {
            delegate?.validationSuccess(username: username, password: password)
        } else {
            delegate?.validationFailed()
        }
    }
        
    func validateInput(username: String, password: String, confirmPassword: String) -> Bool {
        return !username.isEmpty && !password.isEmpty && password == confirmPassword
    }
}
