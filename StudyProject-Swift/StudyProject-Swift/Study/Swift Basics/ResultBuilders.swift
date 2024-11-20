//
//  ResultBuilders.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 24/09/24.
//

import Foundation

@resultBuilder
struct HTMLBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "\n")
    }
}

func buildHTML(@HTMLBuilder _ content: () -> String) -> String {
    return """
    <html>
    <body>
    \(content())
    </body>
    </html>
    """
}

// ----------

struct CustomButton {
    let title: String
    let action: () -> Void
}

@resultBuilder
struct ButtonBuilder {
    static func buildBlock(_ components: CustomButton...) -> [CustomButton] {
        components
    }
}

func createButtons(@ButtonBuilder _ buttons: () -> [CustomButton]) -> [CustomButton] {
    buttons()
}
