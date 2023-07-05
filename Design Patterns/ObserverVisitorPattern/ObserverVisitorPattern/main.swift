//
//  main.swift
//  ObserverVisitorPattern
//
//  Created by Damir Aliyev on 27.04.2023.
//

class Investor {
    let id: Int
    let name: String
    private var stocks: [Stock] = []
    
    func update(stock: Stock, oldPrice: Float, newPrice: Float) {
        print("To \(name): ")
        print("Stock price was updated from \(oldPrice) to \(newPrice)")
        print("   ")
    }
    
    func addStock(stock: Stock) {
        self.stocks.append(stock)
    }
    
    func removeStock(stock: Stock) {
        for i in 0..<stocks.count {
            if stocks[i].symbol == stock.symbol {
                stocks.remove(at: i)
                break
            }
        }
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    func showStocks() {
        for stock in stocks {
            print(stock.symbol)
        }
    }
    
}

class Stock {
    let symbol: String
    private var price: Float
    private var investors: [Investor] = []
    
    func registerInvestor(investor: Investor) {
        investors.append(investor)
        investor.addStock(stock: self)
    }
    
    func unregisterInvestor(investor: Investor) {
        for i in 0..<investors.count {
            if investor.id == investors[i].id {
                investor.removeStock(stock: self)
                investors.remove(at: i)
                break
            }
        }

    }
    
    func updatePrice(newPrice: Float) {
        investors.forEach { $0.update(stock: self, oldPrice: price, newPrice: newPrice) }
        
        self.price = newPrice
    }
    
    init(symbol: String, price: Float) {
        self.symbol = symbol
        self.price = price
    }
}

let appleStock = Stock(symbol: "AAPL", price: 163.76)
let googleStock = Stock(symbol: "GOOGL", price: 103.71)
let microsoftStock = Stock(symbol: "MSFT", price: 295.37)

let investor1 = Investor(id: 1, name: "Warren Buffet")
let investor2 = Investor(id: 2, name: "Mark Cuban")
let investor3 = Investor(id: 3, name: "Kevin O'Leary")

appleStock.registerInvestor(investor: investor1)
appleStock.registerInvestor(investor: investor2)
appleStock.registerInvestor(investor: investor3)

googleStock.registerInvestor(investor: investor2)
googleStock.registerInvestor(investor: investor3)

appleStock.updatePrice(newPrice: 170.5)
//Output:
//To Warren Buffet:
//Stock price was updated from 163.76 to 170.5
//
//To Mark Cuban:
//Stock price was updated from 163.76 to 170.5
//
//To Kevin O'Leary:
//Stock price was updated from 163.76 to 170.5


appleStock.unregisterInvestor(investor: investor3)
appleStock.updatePrice(newPrice: 171)
//Output:
//To Warren Buffet:
//Stock price was updated from 170.5 to 171.0
//
//To Mark Cuban:
//Stock price was updated from 170.5 to 171.0

googleStock.registerInvestor(investor: investor1)
googleStock.registerInvestor(investor: investor2)
googleStock.registerInvestor(investor: investor3)

investor1.showStocks()
//Output:
//AAPL
//GOOGL

appleStock.unregisterInvestor(investor: investor1)
investor1.showStocks()
//Output:
//GOOGL


//Visitor Pattern

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
