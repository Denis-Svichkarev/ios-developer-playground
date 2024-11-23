//
//  DependencyInjectionExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 20/11/24.
//

protocol NetworkServiceProtocol {
    func fetchData() -> String
}

class NetworkService: NetworkServiceProtocol {
    func fetchData() -> String {
        return "Data from network"
    }
}

class DataController {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func displayData() {
        let data = networkService.fetchData()
        print(data)
    }
}
