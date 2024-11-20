//
//  FactoryMethodExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 13.10.2024.
//

import Foundation

protocol Button {
    func render()
}

class WindowsButton: Button {
    func render() {
        print("Rendering Windows button")
    }
}

class MacOSButton: Button {
    func render() {
        print("Rendering MacOS button")
    }
}

// Factory
protocol Dialog {
    func createButton() -> Button
    func renderUI()
}

class WindowsDialog: Dialog {
    func createButton() -> Button {
        return WindowsButton()
    }
    
    func renderUI() {
        let button = createButton()
        button.render()
    }
}

class MacOSDialog: Dialog {
    func createButton() -> Button {
        return MacOSButton()
    }
    
    func renderUI() {
        let button = createButton()
        button.render()
    }
}
