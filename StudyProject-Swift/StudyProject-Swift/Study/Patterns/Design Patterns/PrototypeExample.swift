//
//  PrototypeExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 11/11/24.
//

import Foundation

protocol Prototype: AnyObject, NSCopying {
    func clone() -> Self
}

class SuperCar: Prototype {
    var model: String
    var color: String
    
    init(model: String, color: String) {
        self.model = model
        self.color = color
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return SuperCar(model: self.model, color: self.color)
    }
    
    func clone() -> Self {
        return self.copy() as! Self
    }
}
