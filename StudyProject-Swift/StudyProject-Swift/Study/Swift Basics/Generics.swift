//
//  Generics.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 22/09/24.
//

import Foundation

protocol Describable {
    var description: String { get }
}

struct Human: Describable {
    var name: String
    var description: String {
        return "Human: \(name)"
    }
}

struct Car: Describable {
    var model: String
    var description: String {
        return "Car model: \(model)"
    }
}

func printDescription<T: Describable>(item: T) {
    print(item.description)
}

// ------

protocol GenericProtocol {
    associatedtype T
    func test(item: T)
}

struct TestStruct: GenericProtocol {
    typealias T = String
    
    func test(item: String) {
        print(">> \(item)")
    }
}

struct TestStruct2: GenericProtocol {
    typealias T = Float
    
    func test(item: Float) {
        print(">> \(item)")
    }
}

// ------

func swapValues<T>(a: inout T, b: inout T) {
    let temp = a
    a = b
    b = temp
}
