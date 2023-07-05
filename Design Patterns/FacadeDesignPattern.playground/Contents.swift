import UIKit


class Book {
    let name: String
    var available: Bool
    
    init(name: String, available: Bool) {
        self.name = name
        self.available = available
    }
}

struct User {
    let name: String
    let surname: String
}

class UserManagementSystem {
    private var users = [
        User(name: "Damir", surname: "Aliyev"),
        User(name: "Bekzhan", surname: "Zhakas"),
        User(name: "Sultan", surname: "Suleimenov")
    ]
    
    func addUser(name: String, surname: String) {
        let newUser = User(name: name, surname: surname)
        users.append(newUser)
    }
    
    func doesUserExist(name: String, surname: String) -> Bool {
        for user in users {
            if user.name == name && user.surname == surname {
                return true
            }
        }
        
        return false
    }
}

class LibrarySystem {
    
    private var books = [
        Book(name: "Clean Code", available: true),
        Book(name: "Clean Coder", available: true),
        Book(name: "Clean Architecture", available: true),
        Book(name: "Design Patterns", available: true)
    ]
    
    func searchBook(withName bookName: String) -> Book? {
        for book in books {
            if book.name == bookName {
                return book
            }
        }
        
        print("There is not such book in our library.")
        return nil
    }
    
    func checkAvailability(of bookName: String) -> Bool {
        guard let book = searchBook(withName: bookName) else {
            return false
        }
        
        return book.available
    }
    
    func giveBookToTheClient(bookName: String) {
        guard let book = searchBook(withName: bookName) else {
            print("We don't have this book.")
            return
        }
        
        print("Here is your book!")
        book.available = false
    }
    
    func takeBookFromClient(bookName: String) {
        guard let book = searchBook(withName: bookName) else {
            print("We don't have such book in out library.")
            return
        }
        
        print("Thank you!")
        book.available = true
    }
    
    func showAllBooks() {
        for book in books {
            print("Book: \(book.name), available: \(book.available)")
        }
    }
    
}

protocol LibraryFacadeInterface {
    func signIn(name: String, surname: String)
    func signUp(name: String, surname: String)
    func borrowBook(named book: String)
    func returnBook(named book: String)
    func seeBooks()
}


class LibraryFacade: LibraryFacadeInterface {
    
    private let librarySystem = LibrarySystem()
    private let userManagementSystem = UserManagementSystem()
    
    private var isAuthorized = false
    
    func signIn(name: String, surname: String) {
        isAuthorized = userManagementSystem.doesUserExist(name: name, surname: surname)
        
        if isAuthorized {
            print("Success!")
        } else {
            print("We do not have such user in our system. Please, sign up if you haven't yet.")
        }
    }
    
    func signUp(name: String, surname: String) {
        userManagementSystem.addUser(name: name, surname: surname)
        print("Successully signed up!")
    }
    
    func borrowBook(named book: String) {
        if isAuthorized == false {
            print("Unauthorized access.")
            return
        }
        
        let isAvailable = librarySystem.checkAvailability(of: book)
        
        if isAvailable {
            librarySystem.giveBookToTheClient(bookName: book)
        }
    }
    
    func returnBook(named book: String) {
        if isAuthorized == false {
            print("Unauthorized access.")
            return
        }
        librarySystem.takeBookFromClient(bookName: book)
    }
    
    func seeBooks() {
        if isAuthorized == false {
            print("Unauthorized access.")
            return
        }
        librarySystem.showAllBooks()
    }
}

let libraryFacade = LibraryFacade()

libraryFacade.borrowBook(named: "Clean Code")
//Output: Unauthorized access.

libraryFacade.signIn(name: "Omar", surname: "Polat")
//Output: We do not have such user in our system. Please, sign up if you haven't yet.

libraryFacade.signUp(name: "Omar", surname: "Polat")
//Output: Successully signed up!

libraryFacade.signIn(name: "Omar", surname: "Polat")
//Output: Success!

libraryFacade.borrowBook(named: "Agile Software Development")
//Output: There is not such book in our library.

libraryFacade.borrowBook(named: "Clean Code")

libraryFacade.seeBooks()
//Output:
//Book: Clean Code, available: false
//Book: Clean Coder, available: true
//Book: Clean Architecture, available: true
//Book: Design Patterns, available: true


libraryFacade.returnBook(named: "Clean Code")

libraryFacade.seeBooks()
//Output:
//Book: Clean Code, available: true
//Book: Clean Coder, available: true
//Book: Clean Architecture, available: true
//Book: Design Patterns, available: true

