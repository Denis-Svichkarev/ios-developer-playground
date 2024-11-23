//
//  FactoryMethodExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 13.10.2024.
//

import Foundation

protocol TButton {
    func render()
}

class WindowsButton: TButton {
    func render() {
        print("Rendering Windows button")
    }
}

class MacOSButton: TButton {
    func render() {
        print("Rendering MacOS button")
    }
}

// Factory
protocol Dialog {
    func createButton() -> TButton
    func renderUI()
}

class WindowsDialog: Dialog {
    func createButton() -> TButton {
        return WindowsButton()
    }
    
    func renderUI() {
        let button = createButton()
        button.render()
    }
}

class MacOSDialog: Dialog {
    func createButton() -> TButton {
        return MacOSButton()
    }
    
    func renderUI() {
        let button = createButton()
        button.render()
    }
}
