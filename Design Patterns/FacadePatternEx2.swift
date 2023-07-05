//
//  FacadePatternEx1.swift
//  
//

import UIKit


class ProductCatalogSystem {
    private var catalog = [
        "Clean Code",
        "Agile Software Development",
        "Design Patterns",
        "Clean Architecture"
    ]
    
    func seeCatalog() {
        for item in catalog {
            print(item)
        }
    }
}


class InventoryManagementSystem {
    private var basket = [String]()
    
    func addToBasket(item: String) {
        basket.append(item)
        print("Added to basket.")
    }
    
    func removeFromBasket(item: String) {
        for i in 0..<basket.count {
            if basket[i] == item {
                basket.remove(at: i)
                print("Removed from basket.")
            }
        }
    }
    
    func itemsInBasket() -> [String] {
        return basket
    }
}


class OrderProcessingSystem {
    var orders = [String]()
    
    func orderItem(item: String) {
        orders.append(item)
    }
    
    func seeOrdersHistory() {
        
        if orders.count == 0 {
            print("You haven't ordered anything yet.")
        }
        
        for order in orders {
            print(order)
        }
    }
}


class PaymentProcessingSystem {
    
    func checkBankCardInfo() -> Bool {
        print("Checking bank card info.")
        return true
    }
    
    func completePaymentOperation() {
        print("Items was successfully purchased! Thank you!")
    }
}


protocol ShopFacadeInterface {
    func seeCatalog()
    func addToBasket(item: String)
    func removeFromBasket(item: String)
    func viewOrderHistory()
    func buy()
}


class BookShopFacade: ShopFacadeInterface {
    private let productCatalogSystem = ProductCatalogSystem()
    private let inventoryManagementSystem = InventoryManagementSystem()
    private let orderProcessingSystem = OrderProcessingSystem()
    private let paymentProcessingSystem = PaymentProcessingSystem()
    
    
    func seeCatalog() {
        productCatalogSystem.seeCatalog()
    }
    
    func addToBasket(item: String) {
        inventoryManagementSystem.addToBasket(item: item)
    }
    
    func removeFromBasket(item: String) {
        inventoryManagementSystem.removeFromBasket(item: item)
    }
    
    func viewOrderHistory() {
        orderProcessingSystem.seeOrdersHistory()
    }
    
    func buy() {
        if paymentProcessingSystem.checkBankCardInfo() {
            
            for item in inventoryManagementSystem.itemsInBasket() {
                orderProcessingSystem.orderItem(item: item)
            }
            
            paymentProcessingSystem.completePaymentOperation()
        }
        
    }
}

let bookShop = BookShopFacade()

bookShop.seeCatalog()
//Clean Code
//Agile Software Development
//Design Patterns
//Clean Architecture

bookShop.addToBasket(item: "Clean Code")
// Added to basket.

bookShop.addToBasket(item: "Clean Architecture")
// Added to basket.

bookShop.removeFromBasket(item: "Clean Architecture")
// Removed from basket.

bookShop.addToBasket(item: "Design Patterns")
// Added to basket.

bookShop.buy()
// Items was successfully purchased! Thank you!

bookShop.viewOrderHistory()
//Clean Code
//Design Patterns


//  From these tasks, we can see that the Facade makes life easier for the client, because he does not have to manage all the system himself. Instead of the client, Facade will do it. The client just needs to access the methods provided by the Facade.


