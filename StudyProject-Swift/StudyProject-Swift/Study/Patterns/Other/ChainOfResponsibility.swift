//
//  ChainOfResponsibility.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 20/11/24.
//

protocol Handler {
    var next: Handler? { get set }
    func handle(request: String)
}

class LoggerHandler: Handler {
    var next: Handler?
    
    func handle(request: String) {
        print("LoggerHandler: Logging request - \(request)")
        next?.handle(request: request)
    }
}

class AuthenticationHandler: Handler {
    var next: Handler?
    
    func handle(request: String) {
        if request.contains("auth") {
            print("AuthenticationHandler: Authenticating request")
            next?.handle(request: request)
        } else {
            print("AuthenticationHandler: No authentication needed")
        }
    }
}

class DataHandler: Handler {
    var next: Handler?
    
    func handle(request: String) {
        print("DataHandler: Processing data for request - \(request)")
        // End of chain
    }
}
