//
//  SingletonExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 13.10.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String) {
        print("Fetching data from \(url)")
    }
}
