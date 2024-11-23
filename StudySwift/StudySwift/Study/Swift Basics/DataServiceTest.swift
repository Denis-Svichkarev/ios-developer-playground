//
//  DataServiceTest.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 19/09/24.
//

import Foundation

func fetchDataFromMultipleSources() async {
    await withTaskGroup(of: String.self) { group in
        group.addTask {
            return await fetchData(from: "Source 1")
        }
        
        group.addTask {
            return await fetchData(from: "Source 2")
        }
        
        group.addTask {
            return await fetchData(from: "Source 3")
        }
        
        for await result in group {
            print("Received data: \(result)")
        }
        
        print("All tasks are complete!")
    }
}

func fetchData(from source: String) async -> String {
    // Simulate async request
    return "Data from \(source)"
}

func testStructuredConcurrency() {
    Task {
        await fetchDataFromMultipleSources()
    }
}

// -----

enum NetworkError: Error {
    case badURL
    case requestFailed
    case unknown
}

func fetchData(from urlString: String) -> Result<String, NetworkError> {
    guard let url = URL(string: urlString) else {
        return .failure(.badURL)
    }
    
    print(url)

    let isSuccess = Bool.random()
    
    if isSuccess {
        return .success("Fetched data from \(urlString)")
    } else {
        return .failure(.requestFailed)
    }
}

func testResultType() {
    let result = fetchData(from: "https://example.com")
    
    let uppercasedResult = result.map { data in
        data.uppercased()
    }
    
    switch uppercasedResult {
    case .success(let data):
        print("Success: \(data)")
    case .failure(let error):
        switch error {
        case .badURL:
            print("Failure: Invalid URL.")
        case .requestFailed:
            print("Failure: Request failed.")
        case .unknown:
            print("Failure: Unknown error.")
        }
    }
}
