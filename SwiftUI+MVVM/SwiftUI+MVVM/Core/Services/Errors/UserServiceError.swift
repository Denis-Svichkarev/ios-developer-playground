//
//  UserServiceError.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Foundation

enum UserServiceError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    case networkError(Error)
    case notFound
    case unauthorized
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .notFound:
            return "User not found"
        case .unauthorized:
            return "Invalid credentials"
        }
    }
}
