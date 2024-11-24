//
//  ImageURLGenerator.swift
//  Swift+VIPER
//
//  Created by Denis Svichkarev on 24/11/24.
//

import Foundation

final class ImageURLGenerator {
    static func generateRandomImageURL() async throws -> String {
        let url = URL(string: "https://picsum.photos/200/300?random=\(Int.random(in: 1...100))")!
        let (_, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw ImageURLGeneratorError.failedToGenerateImageURL
        }

        return url.absoluteString
    }
}

enum ImageURLGeneratorError: Error {
    case failedToGenerateImageURL
}
