//
//  SOLIDAssignment.swift
//  
//
//  Created by Damir Aliyev on 08.05.2023.
//


//Dependency inversion. We will not use concrete classes, instead we will use abtract interface
protocol Item {
    var id: String { get }
    var title: String { get }
    var author: String { get }
}

class Book: Item {
    let id: String
    let title: String
    let author: String
    let numberOfPages: Int

    init(id: String, title: String, author: String, numberOfPages: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.numberOfPages = numberOfPages
    }
}


class Magazine: Item {
    let id: String
    let title: String
    let author: String
    let publicationDate: String

    init(id: String, title: String, author: String, publicationDate: String) {
        self.id = id
        self.title = title
        self.author = author
        self.publicationDate = publicationDate
    }
}


class CD: Item {
    let id: String
    let title: String
    let author: String
    let artist: String
    let numberOfTracks: Int

    init(id: String, title: String, author: String, artist: String, numberOfTracks: Int) {
        self.id = id
        self.title = title
        self.author = author
        self.artist = artist
        self.numberOfTracks = numberOfTracks
    }
}

//Dependency inversion. We will not use concrete classes, instead we will use abtract interface
protocol Staff {
    var id: Int { get }
    var name: String { get }
    var surname: String { get }
}

//Dependency inversion. We will not use concrete classes, instead we will use abtract interface
protocol User {
    var id: Int { get }
    var name: String { get }
    var surname: String { get }
}

class Librarian: Staff {
    let id: Int
    let name: String
    let surname: String
   
    init(id: Int, name: String, surname: String) {
        self.id = id
        self.name = name
        self.surname = surname
    }
}


class Client: User {
    let id: Int
    let name: String
    let surname: String
    let address: String
    var borrowedItems: [Item] = []
    
    init(id: Int, name: String, surname: String, address: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.address = address
    }
}

//Dependency inversion. We will not use concrete classes, instead we will use abtract interface
protocol Database {
    associatedtype T
    func add(_ item: T)
    func remove(_ item: T)
    func get(_ item: T) -> T?
}

class UsersDatabase: Database {
    typealias T = User
    
    private var users: [Int: User] = [:]
    
    func add(_ user: User) {
        users[user.id] = user
    }
    
    func remove(_ user: User) {
        users.removeValue(forKey: user.id)
    }
    
    func get(_ user: User) -> User? {
        return users[user.id]
    }
}

class StaffDatabase: Database {
    typealias T = Staff
    
    private var staffMembers: [Int: Staff] = [:]
    
    func add(_ staff: Staff) {
        staffMembers[staff.id] = staff
    }
    
    func remove(_ staff: Staff) {
        staffMembers.removeValue(forKey: staff.id)
    }
    
    func get(_ staff: Staff) -> Staff? {
        return staffMembers[staff.id]
    }
}

//I tried to apply Single Responsibility principle everywhere. It means, that I tried to create classes in such way, that they will have only one responsibility and only one reason to change

//Liskov substitution. Here, I used protocols everywhere instead of inheritence, so LS is not applied.

//Interface seggregation. I tried to put to the interfaces only the necessary things, so classes that implements this interface will not depend on methods, that they will not use.

//Dependency inversion. I have used abstractions instead of concrete classes. For example: Item, Staff, User, Database
