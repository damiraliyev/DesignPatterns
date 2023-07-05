//
//  ObserverAssignment.swift
//  
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
