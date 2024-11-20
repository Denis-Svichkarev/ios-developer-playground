//
//  ExistentialAny.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 20/09/24.
//

import Foundation

protocol SceneObject {
    func create()
}

protocol GameObject {
    func makeSound()
}

struct Dog: SceneObject, GameObject {
    func create() {
        print("Create Dog")
    }
    
    func makeSound() {
        print("Woof!")
    }
}

struct Cat: SceneObject, GameObject {
    func create() {
        print("Create Cat")
    }
    
    func makeSound() {
        print("Meow!")
    }
}

let animals: [any GameObject & SceneObject] = [Dog(), Cat()]

func doSomething(value: any GameObject & SceneObject) {
    value.create()
    value.makeSound()
}

func testExistentialAny() {
    for animal in animals {
        animal.makeSound()
        
        doSomething(value: animal)
    }
}
