//
//  FakeUserService.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 22/11/24.
//

import Combine
import Foundation

protocol UserServiceProtocol {
    var currentUser: User? { get }
    var isLoggedIn: Bool { get }
    
    func login(email: String, password: String) -> AnyPublisher<User, UserServiceError>
    func logout()
}

class UserService: UserServiceProtocol {
    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder
    private let isFakeData: Bool
    
    private(set) var currentUser: User?
    
    var isLoggedIn: Bool {
        currentUser != nil
    }
    
    init(
          baseURL: URL = URL(string: "https://real-api.com")!,
          session: URLSession = .shared,
          decoder: JSONDecoder = JSONDecoder(),
          isFakeData: Bool = false
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
        self.isFakeData = isFakeData
        
        setupDecoder()
    }
    
    // MARK: - Public Methods
       
    func login(email: String, password: String) -> AnyPublisher<User, UserServiceError> {
        guard !email.isEmpty, !password.isEmpty else {
            return Fail(error: .unauthorized).eraseToAnyPublisher()
        }
        
        return isFakeData ? fetchFromFile() : fetchFromAPI(email: email, password: password)
    }
    
    func logout() {
        currentUser = nil
    }
   
    // MARK: - Private Methods
        
    private func setupDecoder() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    private func fetchFromAPI(email: String, password: String) -> AnyPublisher<User, UserServiceError> {
        let endpoint = baseURL.appendingPathComponent("user/login")
        
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let credentials = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: credentials)
        
        return session.dataTaskPublisher(for: request)
            .mapError { UserServiceError.networkError($0) }
            .tryMap { [weak self] data, response -> User in
                guard let self = self else { throw UserServiceError.invalidResponse }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw UserServiceError.invalidResponse
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    return try self.decoder.decode(User.self, from: data)
                case 401:
                    throw UserServiceError.unauthorized
                case 404:
                    throw UserServiceError.notFound
                default:
                    throw UserServiceError.invalidResponse
                }
            }
            .mapError { error -> UserServiceError in
                if let error = error as? UserServiceError {
                    return error
                }
                if error is DecodingError {
                    return .decodingError
                }
                return .networkError(error)
            }
            .handleEvents(receiveOutput: { [weak self] user in
                self?.currentUser = user
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func fetchFromFile() -> AnyPublisher<User, UserServiceError> {
        guard let url = Bundle.main.url(forResource: "user", withExtension: "json") else {
            return Fail(error: .notFound).eraseToAnyPublisher()
        }
        
        return Just(url)
            .tryMap { try Data(contentsOf: $0) }
            .decode(type: User.self, decoder: decoder)
            .mapError { error -> UserServiceError in
                if error is DecodingError {
                    return .decodingError
                }
                return .networkError(error)
            }
            .handleEvents(receiveOutput: { [weak self] user in
                self?.currentUser = user
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
