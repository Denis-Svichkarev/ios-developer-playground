//
//  BuilderExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 20/10/24.
//

struct Pizza {
    var dough: String?
    var sauce: String?
    var topping: String?
}

protocol PizzaBuilder {
    func setDough(_ dough: String) -> Self
    func setSauce(_ sauce: String) -> Self
    func setTopping(_ topping: String) -> Self
    func build() -> Pizza
}

class ConcretePizzaBuilder: PizzaBuilder {
    private var pizza = Pizza()
    
    func setDough(_ dough: String) -> Self {
        pizza.dough = dough
        return self
    }
    
    func setSauce(_ sauce: String) -> Self {
        pizza.sauce = sauce
        return self
    }
    
    func setTopping(_ topping: String) -> Self {
        pizza.topping = topping
        return self
    }
    
    func build() -> Pizza {
        return pizza
    }
}

class PizzaDirector {
    private var builder: PizzaBuilder
    
    init(builder: PizzaBuilder) {
        self.builder = builder
    }
    
    func makeMargherita() -> Pizza {
        return builder
            .setDough("Thin Crust")
            .setSauce("Tomato")
            .setTopping("Mozzarella")
            .build()
    }
    
    func makePepperoni() -> Pizza {
        return builder
            .setDough("Thick Crust")
            .setSauce("Barbecue")
            .setTopping("Pepperoni")
            .build()
    }
}
