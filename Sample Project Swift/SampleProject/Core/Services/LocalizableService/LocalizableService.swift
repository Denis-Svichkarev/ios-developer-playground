//
//  LocalizableService.swift
//  SampleProject
//
//  Created by Denis Svichkarev on 14/07/24.
//

import Foundation

protocol LocalizableServiceProtocol {
    func localizedString(forKey key: String) -> String
    func localizedString(forKey key: String, tableName: String) -> String
}

class LocalizableService: LocalizableServiceProtocol {
    func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    func localizedString(forKey key: String, tableName: String) -> String {
        return NSLocalizedString(key, tableName: tableName, bundle: .main, value: "", comment: "")
    }
}
