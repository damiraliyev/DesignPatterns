//
//  DecoratorPatternEx1.swift
//  
//
//  Created by Damir Aliyev on 28.03.2023.
//

import Foundation

protocol Pizza {
    func getPrice() -> Int
    
    func ingredients() -> String
}

class BasePizza: Pizza {
    func getPrice() -> Int {
        return 2000
    }
    
    func ingredients() -> String {
        return "Cheese"
    }
    
}

class PizzaDecorator: Pizza {
    private var pizza: Pizza
    
    init(pizza: Pizza) {
        self.pizza = pizza
    }
    
    func getPrice() -> Int {
        return pizza.getPrice()
    }
    
    func ingredients() -> String {
        return pizza.ingredients()
    }
}

class ChickenTopping: PizzaDecorator {
    override func getPrice() -> Int {
        return super.getPrice() + 500
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Chicken"
    }
}

class MushroomTopping: PizzaDecorator {
    override func getPrice() -> Int {
        return super.getPrice() + 200
    }
    
    override func ingredients() -> String {
        return super.ingredients() + ", Mushroom"
    }
}


let pizza = BasePizza()
print(pizza.ingredients())
print(pizza.getPrice())
//Output: Cheese
//        2000
let chickenPizza = ChickenTopping(pizza: pizza)
print(chickenPizza.ingredients())
print(chickenPizza.getPrice())
//Output: Cheese, Chicken
//        2500

let mushroomWithChickenPizza = MushroomTopping(pizza: chickenPizza)
print(mushroomWithChickenPizza.ingredients())
print(mushroomWithChickenPizza.getPrice())
//Output: Cheese, Chicken, Mushroom
//        2700


