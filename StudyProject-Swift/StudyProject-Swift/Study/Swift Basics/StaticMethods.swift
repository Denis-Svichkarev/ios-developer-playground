//
//  StaticMethods.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 22/09/24.
//

import Foundation

class ParentClass {
    class func description() -> String {
        return "Parent Class"
    }
}

class ChildClass: ParentClass {
    override class func description() -> String {
        return "Child Class"
    }
}
