//
//  Person.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 25.08.2024.
//

import Foundation

class Person {
    private var _age: Int = 0
    
    var firstName: String
    var lastName: String
    
    lazy var fullName: String = {
        return "\(firstName) \(lastName)"
    }()
    
    var pet: Animal? {
        willSet {
            print("Will set pet \(newValue?.name ?? "Unknown")")
        }
        didSet {
            print("Pet changed from \(oldValue?.name ?? "Unknown") to \(pet?.name ?? "Unknown")")
        }
    }
    
    var age: Int {
        get {
            return _age
        }
        set {
            if newValue > 0 {
                _age = newValue
            }
        }
    }
    
    struct Address {
        var street: String
        var city: String
    }
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    func greet() {
        print("Hello, my name is \(self.firstName) and I am \(age) years old.")
    }
    
    deinit {
        print("\(firstName) is being deinitialized")
    }
}
