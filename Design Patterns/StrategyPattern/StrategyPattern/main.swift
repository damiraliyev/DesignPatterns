//
//  main.swift
//  StrategyPattern
//
//  Created by Damir Aliyev on 15.04.2023.
//

import Foundation

protocol Routable {
    func buildRoute(from a: String, to b: String)
}

class BusRouteBuilder: Routable {
    func buildRoute(from a: String, to b: String) {
        print("From \(a) to \(b) with BUS.")
    }
}

class CarRouteBuilder: Routable {
    func buildRoute(from: String, to: String) {
        print("From \(from) to \(to) with CAR.")
    }
}

class Navigator {
    
    var strategy: Routable
    
    init(strategy: Routable) {
        self.strategy = strategy
    }
    
    func buildRoute(from: String, to: String) {
        strategy.buildRoute(from: from, to: to)
    }
    
    func setStrategy(strategy: Routable) {
        self.strategy = strategy
    }
}

let busRoute = BusRouteBuilder()

let navigator = Navigator(strategy: busRoute)
navigator.buildRoute(from: "sairan", to: "sdu")

let carRoute = CarRouteBuilder()
navigator.setStrategy(strategy: carRoute)
navigator.buildRoute(from: "Sairan", to: "SDU")

//
//class Database {
//    func connect() {
//
//    }
//
//    func read() {
//
//    }
//
//    func write() {
//
//    }
//
//    func joinTables() {
//
//    }
//}

//class MySQLDatabase: Database {
//    override func connect() {
//
//    }
//
//    override func read() {
//
//    }
//
//    override func write() {
//        <#code#>
//    }
//
//    override func joinTables() {
//
//    }
//}
