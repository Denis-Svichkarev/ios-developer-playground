//
//  AdapterExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 12/11/24.
//

import Foundation

protocol Target {
    func request()
}

class Adaptee {
    func specificRequest() {
        print("Specific request")
    }
}

class Adapter: Target {
    private let adaptee: Adaptee
    
    init(adaptee: Adaptee) {
        self.adaptee = adaptee
    }
    
    func request() {
        adaptee.specificRequest()
    }
}
