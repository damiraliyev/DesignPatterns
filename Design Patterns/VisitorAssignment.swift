//
//  VisitorAssignment.swift
//  
//
//  Created by Damir Aliyev on 27.04.2023.
//

protocol Visitor {
    var totalWeight: Float { get set }
    var totalVolume: Float { get set }
    func visitBook(book: Book) -> Float
    func visitMovie(movie: Movie) -> Float
    func visitMusic(music: Music) -> Float
    func calculateCost() -> Float
}

class ShippingCostVisitor: Visitor {
    var totalWeight: Float = 0
    var totalVolume: Float = 0
    
    func visitBook(book: Book) -> Float {
        totalVolume = book.width * book.height * book.depth
        totalWeight = book.weight
        
        return calculateCost()
    }
    
    func visitMovie(movie: Movie) -> Float {
        totalVolume = movie.width * movie.height * movie.depth
        totalWeight = movie.weight
        return calculateCost()
    }
    
    func visitMusic(music: Music) -> Float {
        totalVolume = music.width * music.height * music.depth
        totalWeight = music.weight
        return calculateCost()
    }
    
    func calculateCost() -> Float {
        let price = totalVolume * 12 + totalWeight * 5
        
        return price
    }
}

protocol Visitable {
    func accept(visitor: Visitor) -> Float
}

class Product {
    let name: String
    let price: Float
    let weight: Float
    let width: Float
    let height: Float
    let depth: Float
    
    init(name: String, price: Float, weight: Float, width: Float, height: Float, depth: Float) {
        self.name = name
        self.price = price
        self.weight = weight
        self.width = width
        self.height = height
        self.depth = depth
    }
}

class Book: Product, Visitable {
    override init(name: String, price: Float, weight: Float, width: Float, height: Float, depth: Float) {
        super.init(name: name, price: price, weight: weight, width: width, height: height, depth: depth)
    }
    
    func accept(visitor: Visitor) -> Float {
        visitor.visitBook(book: self)
    }
}

class Movie: Product, Visitable {
    override init(name: String, price: Float, weight: Float, width: Float, height: Float, depth: Float) {
        super.init(name: name, price: price, weight: weight, width: width, height: height, depth: depth)
    }
    
    func accept(visitor: Visitor) -> Float {
        visitor.visitMovie(movie: self)
    }
}

class Music: Product, Visitable {
    override init(name: String, price: Float, weight: Float, width: Float, height: Float, depth: Float) {
        super.init(name: name, price: price, weight: weight, width: width, height: height, depth: depth)
    }
    
    func accept(visitor: Visitor) -> Float {
        visitor.visitMusic(music: self)
    }
}

class Order {
    let products: [Visitable]
    var cost: Float = 0
    
    init(products: [Visitable]) {
        self.products = products
    }
    
    func calculateTotalCost(visitor: Visitor) -> Float {
        self.products.forEach { product in
            cost += product.accept(visitor: visitor)
        }
        
        return cost
    }
}


let book = Book(name: "Can't hurt me", price: 30, weight: 0.7, width: 0.2, height: 0.35, depth: 0.05)

let musicAlbum = Music(name: "Album", price: 10, weight: 0.5, width: 0.25, height: 0.25, depth: 0.10)

let movieDisk = Movie(name: "Interstellar", price: 10, weight: 0.4, width: 0.15, height: 0.20, depth: 0.04)

let products: [Visitable] = [book, musicAlbum, movieDisk]

let order = Order(products: products)

let visitor = ShippingCostVisitor()
print(order.calculateTotalCost(visitor: visitor))
//Output:
//8.1314
