//
//  UserService.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine
import Foundation

class UserService: UserServiceProtocol {
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    private let isFakeData: Bool
    private let userState: UserState
    
    init(
          baseURL: URL = URL(string: "https://real-api.com")!,
          session: URLSession = .shared,
          decoder: JSONDecoder = JSONDecoder(),
          isFakeData: Bool = false,
          userState: UserState
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
        self.isFakeData = isFakeData
        self.userState = userState
        
        setupDecoder()
    }
    
    // MARK: - Public Methods
    
    func login(email: String, password: String) async throws -> User {
        guard !email.isEmpty, !password.isEmpty else {
            throw UserServiceError.unauthorized
        }
        
        let user = try await (isFakeData ? fetchFromFile() : fetchFromAPI(email: email, password: password))
        await MainActor.run {
            userState.updateUser(user)
        }
        return user
    }
    
    func logout() {
        userState.updateUser(nil)
    }
   
    // MARK: - Private Methods
        
    private func setupDecoder() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    private func fetchFromAPI(email: String, password: String) async throws -> User  {
        let endpoint = baseURL.appendingPathComponent("user/login")
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: credentials)
        
        let (data, response) = try await session.data(for: request)
            
        guard let httpResponse = response as? HTTPURLResponse else {
            throw UserServiceError.invalidResponse
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            do {
                return try decoder.decode(User.self, from: data)
            } catch {
                throw UserServiceError.decodingError
            }
        case 401:
            throw UserServiceError.unauthorized
        case 404:
            throw UserServiceError.notFound
        default:
            throw UserServiceError.invalidResponse
        }
    }
    
    private func fetchFromFile() async throws -> User {
        guard let url = Bundle.main.url(forResource: "user", withExtension: "json") else {
            throw UserServiceError.notFound
        }
        
        try await Task.sleep(for: .seconds(2))
        
        let data = try Data(contentsOf: url)
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw UserServiceError.decodingError
        }
    }
}
