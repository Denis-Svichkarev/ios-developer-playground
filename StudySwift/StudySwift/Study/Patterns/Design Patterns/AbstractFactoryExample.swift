//
//  AbstractFactoryExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 13.10.2024.
//

import Foundation

protocol Checkbox {
    func check()
}

class WindowsCheckbox: Checkbox {
    func check() {
        print("Checking Windows checkbox")
    }
}

class MacOSCheckbox: Checkbox {
    func check() {
        print("Checking MacOS checkbox")
    }
}

// Abstract Factory
protocol GUIFactory {
    func createButton() -> TButton
    func createCheckbox() -> Checkbox
}

class WindowsFactory: GUIFactory {
    func createButton() -> TButton {
        return WindowsButton()
    }
    
    func createCheckbox() -> Checkbox {
        return WindowsCheckbox()
    }
}

class MacOSFactory: GUIFactory {
    func createButton() -> TButton {
        return MacOSButton()
    }
    
    func createCheckbox() -> Checkbox {
        return MacOSCheckbox()
    }
}
