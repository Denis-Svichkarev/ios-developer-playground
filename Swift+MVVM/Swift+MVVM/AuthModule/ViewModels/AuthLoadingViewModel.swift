//
//  AuthLoadingViewModel.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 14/07/24.
//

import Foundation

class AuthLoadingViewModel {
    private let localizationService: LocalizableServiceProtocol
    
    init(localizationService: LocalizableServiceProtocol) {
        self.localizationService = localizationService
    }
    
    var screenTitle: String {
        return localizationService.localizedString(forKey: "auth_loading_screen_title", tableName: "AuthLocalizable")
    }
}
