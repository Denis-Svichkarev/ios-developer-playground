//
//  MyStruct.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 25.08.2024.
//

import Foundation

protocol Testable {
    func test()
}

struct MyStruct: Testable {
    var name: String // = "John"
    
//    init() {
//        name = "John"
//    }
    
//    init(withName name: String) {
//        self.name = name
//    }
    
    mutating func changeName() {
        name = "Paul"
    }
    
    func test() {
        print("Hello \(name)")
    }
}
