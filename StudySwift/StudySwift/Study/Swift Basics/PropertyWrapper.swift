//
//  PropertyWrapper.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 22/09/24.
//

import Foundation

@propertyWrapper
struct Uppercased {
    private var value: String

    var wrappedValue: String {
        get { value }
        set { value = newValue.uppercased() }
    }

    init(wrappedValue: String) {
        self.value = wrappedValue.uppercased()
    }
}

struct MyUser {
    @Uppercased var username: String
}
