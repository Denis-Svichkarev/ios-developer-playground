//
//  OpaqueTypes.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 20/09/24.
//

import Foundation

protocol Shape {
    func area() -> Double
}

struct Circle: Shape {
    var radius: Double
    func area() -> Double {
        return .pi * radius * radius
    }
}

struct Square: Shape {
    var side: Double
    func area() -> Double {
        return side * side
    }
}

// This method hides implementation of Circle/Square and has good performance
func makeCircle() -> some Shape {
    return Circle(radius: 5)
}

func testOpaqueTypes() {
    let shape = makeCircle()
    print(shape.area())
}

// This example doesn't work because the return type must be the same
//func makeShape(isCircle: Bool) -> some Shape {
//    if isCircle {
//        return Circle(radius: 5)
//    } else {
//        return Square(side: 3)
//    }
//}
