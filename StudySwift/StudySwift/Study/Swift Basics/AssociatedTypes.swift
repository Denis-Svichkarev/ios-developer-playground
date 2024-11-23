//
//  AssociatedTypes.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 20/09/24.
//

import Foundation

protocol Container {
    associatedtype Item
    var count: Int { get }
    func item(at index: Int) -> Item
}

struct BookContainer: Container {
    var items = ["Book 1", "Book 2", "Book 3"]
    var count: Int { items.count }
    
    func item(at index: Int) -> String {
        return items[index]
    }
}

struct FruitContainer: Container {
    var items = ["Apple", "Banana", "Orange"]
    var count: Int { items.count }
    
    func item(at index: Int) -> String {
        return items[index]
    }
}

func testAssociatedTypes() {
    let containers: [any Container] = [BookContainer(), FruitContainer()]

    for container in containers {
        print(container.item(at: 0))
    }
}

// -----

protocol DataProvider {
    associatedtype DataType
    func provideData() -> DataType
}

struct StringDataProvider: DataProvider {
    typealias DataType = String
    func provideData() -> String {
        return "Sample String"
    }
}

struct IntDataProvider: DataProvider {
    typealias DataType = Int
    func provideData() -> Int {
        return 123
    }
}

