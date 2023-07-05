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



protocol Notification {
    func send(message: String)
}

class BaseNotification: Notification {
    func send(message: String) {
        print("Message '\(message)' sent to user's account.")
    }
}

class BaseNotificationDecorator: Notification {
    private var notification: Notification
    
    init(notification: Notification) {
        self.notification = notification
    }
    
    func send(message: String) {
        notification.send(message: message)
    }
}

class SMSNotification: BaseNotificationDecorator {
    override func send(message: String) {
        super.send(message: message)
        print("Message '\(message)' sent to user's phone number.")
    }
}

class EmailNotification: BaseNotificationDecorator {
    override func send(message: String) {
        super.send(message: message)
        print("Message '\(message)' sent to user's email.")
    }
}

class PushNotification: BaseNotificationDecorator {
    override func send(message: String) {
        super.send(message: message)
        print("Message '\(message)' sent by push notification.")
    }
}

struct User {
    let name: String
    
    var preferredNotificationChannels: Notification
    
}

class UserSystem {
    var users: [User] = []
    
    func sendMessage(message: String) {
        
        for i in stride(from: 0, to: users.count, by: 1) {
            print("To \(users[i].name)")
            users[i].preferredNotificationChannels.send(message: message)
            print("")
        }
    }
}

//Creating different notification options
let notification = BaseNotification()

let baseNotification = BaseNotificationDecorator(notification: notification)

let smsNotification = SMSNotification(notification: baseNotification)

let pushNotification = PushNotification(notification: baseNotification)

let pushSMSNotification = PushNotification(notification: smsNotification)


//creating users
var user1 = User(name: "User1", preferredNotificationChannels: baseNotification)

var user2 = User(name: "User2", preferredNotificationChannels: smsNotification)

var user3 = User(name: "User3", preferredNotificationChannels: pushNotification)

var user4 = User(name: "User4", preferredNotificationChannels: pushSMSNotification)

//creating system
let system = UserSystem()
system.users.append(user1)
system.users.append(user2)
system.users.append(user3)
system.users.append(user4)

system.sendMessage(message: "Test message")

//Output
//To User1
//Message 'Test message' sent to user's account.
//
//To User2
//Message 'Test message' sent to user's account.
//Message 'Test message' sent to user's phone number.
//
//To User3
//Message 'Test message' sent to user's account.
//Message 'Test message' sent by push notification.
//
//To User4
//Message 'Test message' sent to user's account.
//Message 'Test message' sent to user's phone number.
//Message 'Test message' sent by push notification.
//
