//
//  AuthFailureViewModel.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 14/07/24.
//

import Foundation

class AuthFailureViewModel {
    private let localizationService: LocalizableServiceProtocol

    init(localizationService: LocalizableServiceProtocol) {
        self.localizationService = localizationService
    }
    
    var screenTitle: String {
        return localizationService.localizedString(forKey: "auth_failure_screen_title", tableName: "AuthLocalizable")
    }
    
    var tryAgainButtonTitle: String {
        return localizationService.localizedString(forKey: "auth_failure_try_again_button_title", tableName: "AuthLocalizable")
    }
}
