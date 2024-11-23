//
//  DecoratorExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 12/11/24.
//

protocol Coffee {
    func cost() -> Double
    func description() -> String
}

class SimpleCoffee: Coffee {
    func cost() -> Double {
        return 2.0
    }
    
    func description() -> String {
        return "Simple Coffee"
    }
}

class CoffeeDecorator: Coffee {
    private let decoratedCoffee: Coffee
    
    init(decoratedCoffee: Coffee) {
        self.decoratedCoffee = decoratedCoffee
    }
    
    func cost() -> Double {
        return decoratedCoffee.cost()
    }
    
    func description() -> String {
        return decoratedCoffee.description()
    }
}

class MilkDecorator: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 0.5
    }
    
    override func description() -> String {
        return super.description() + ", Milk"
    }
}

class SugarDecorator: CoffeeDecorator {
    override func cost() -> Double {
        return super.cost() + 0.3
    }
    
    override func description() -> String {
        return super.description() + ", Sugar"
    }
}
