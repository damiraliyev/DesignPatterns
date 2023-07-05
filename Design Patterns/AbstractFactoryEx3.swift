//
//  AbstractFactoryEx3.swift
//  
//
//  Created by Damir Aliyev on 25.02.2023.
//

protocol Furniture {
    var name: String {get set}
    var style: String {get set}
    var material: String {get set}
    var price: Float {get set}
}

class Chair: Furniture {
    
    var name: String
    
    var style: String
    
    var material: String
    
    var price: Float
    
    init(name: String, style: String, material: String, price: Float) {
        self.name = name
        self.style = style
        self.material = material
        self.price = price
    }
}

class Table: Furniture {
    
    var name: String
    
    var style: String
    
    var material: String
    
    var price: Float
    
    init(name: String, style: String, material: String, price: Float) {
        self.name = name
        self.style = style
        self.material = material
        self.price = price
    }

}

class Sofa: Furniture {
    
    var name: String
    
    var style: String
    
    var material: String
    
    var price: Float
    
    init(name: String, style: String, material: String, price: Float) {
        self.name = name
        self.style = style
        self.material = material
        self.price = price
    }
    
    
}

protocol FurnitureFactory {
    func createChair() -> Chair
    func createTable() -> Table
    func createSofa() -> Sofa
}

class ModernWoodFactory: FurnitureFactory {
    
    let name = "Modern Wood"
    let style = "Modern"
    let material = "Wood"
    
    func createChair() -> Chair {
        return Chair(name: name + " Chair", style: style, material: material, price: 40)
    }
    
    func createTable() -> Table {
        return Table(name: name + " Table", style: style, material: material, price: 200)
    }
    
    func createSofa() -> Sofa {
        return Sofa(name: name + " Sofa", style: style, material: material, price: 170)
    }
    
}

class TraditionalMetalFactory: FurnitureFactory {
    
    let name = "Traditional Metal"
    let style = "Traditional"
    let material = "Metal"
    
    func createChair() -> Chair {
        return Chair(name: name + " Chair", style: style, material: material, price: 20)
    }
    
    func createTable() -> Table {
        return Table(name: name + " Table", style: style, material: material, price: 140)
    }
    
    func createSofa() -> Sofa {
        return Sofa(name: name + " Sofa", style: style, material: material, price: 100)
    }
    
}

class IndustrialGlassFactory: FurnitureFactory {
    
    let name = "Industrial Glass"
    let style = "Industrial"
    let material = "Glass"
    
    func createChair() -> Chair {
        return Chair(name: name + " Chair", style: style, material: material, price: 70)
    }
    
    func createTable() -> Table {
        return Table(name: name + " Table", style: style, material: material, price: 400)
    }
    
    func createSofa() -> Sofa {
        return Sofa(name: name + " Sofa", style: style, material: material, price: 250)
    }
}


//New
class TraditionalWoodFactory: FurnitureFactory {
    
    let name = "Traditional Wood"
    let style = "Traditional"
    let material = "Wood"
    
    func createChair() -> Chair {
        return Chair(name: name + " Chair", style: style, material: material, price: 40)
    }
    
    func createTable() -> Table {
        return Table(name: name + " Table", style: style, material: material, price: 210)
    }
    
    func createSofa() -> Sofa {
        return Sofa(name: name + " Sofa", style: style, material: material, price: 170)
    }
}


class FurnitureCreator {
    
    private var factory: FurnitureFactory
    
    init(factory: FurnitureFactory) {
        self.factory = factory
    }
    
    func setFactory(factory: FurnitureFactory) {
        self.factory = factory
    }
    
    func createFurnitures() -> [String: Furniture] {
        let chair = factory.createChair()
        let table = factory.createTable()
        let sofa = factory.createSofa()
        
        let furnitures: [String: Furniture] = ["Chair": chair, "Table": table, "Sofa": sofa]
        
        return furnitures
    }
}


let modernWoodFactory = ModernWoodFactory()

let creator = FurnitureCreator(factory: modernWoodFactory)

let furnitures = creator.createFurnitures()

let chair = furnitures["Chair"]
let table = furnitures["Table"]
let sofa = furnitures["Sofa"]

print(chair?.name)
print(table?.name)
print(sofa?.name)
