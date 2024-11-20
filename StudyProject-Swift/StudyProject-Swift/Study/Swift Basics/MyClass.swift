//
//  MyClass.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 24.08.2024.
//

import UIKit

class MyClass {
    var name: String
    var completion: (() -> Void)?
    
    /// Failable Initializer
//    init?(name: String) {
//        if name.isEmpty {
//            return nil
//        }
//        self.name = name
//    }
    
    /// Designated Initializer
    init(name: String) {
        self.name = name
    }
    
    /// Convenience Initializer
    convenience init() {
        self.init(name: "John")
    }
    
    deinit {
        print("Object deallocated")
    }
    
    func test() {
        print("Hello \(name)")
    }
    
    func executeTask() {
        print("Task is executing")
        completion?()
    }
}
