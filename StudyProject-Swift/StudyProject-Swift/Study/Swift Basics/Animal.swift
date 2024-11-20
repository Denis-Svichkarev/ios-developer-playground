//
//  Animal.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 26.08.2024.
//

import Foundation

class Animal {
    var name: String
    unowned let owner: Person

    init(name: String, owner: Person) {
        self.name = name
        self.owner = owner
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}
