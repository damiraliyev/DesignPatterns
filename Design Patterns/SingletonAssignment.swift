import UIKit

class DatabaseConnection {
    
    private let hostname: String
    private let username: String
    private let password: String
    private let databaseName: String
    
    var dict = [String: String]()
    
    private init(hostname: String, username: String, password: String, databaseName: String) {
        self.hostname = hostname
        self.username = username
        self.password = password
        self.databaseName = databaseName
        
        print("Product was initialized")
    }
    
    private static let shared = DatabaseConnection(hostname: "Damir", username: "DamirCS", password: "qwerty", databaseName: "Attendance table")
    
    static func getSharedInstance() -> DatabaseConnection {
        return .shared
    }
    
    func getHostname() -> String {
        return self.hostname
    }
    
    func getUsername() -> String {
        return self.username
    }
    
    func getDatabaseName() -> String {
        return self.databaseName
    }
    
    func connectDatabase() {
        print("Connected to the database with hostname: \(hostname) and database name: \(databaseName)")
    }
    
    
    func POST(username: String, email: String) {
        dict[username] = email
    }
    
    func PUT(username: String, email: String) {
        dict[username] = email
    }
    
    func GET(username: String) -> String? {
        if dict[username] != nil {
            print(200)
            return dict[username]!
        } else {
            print("Request failed with status code: ...")
            return nil
        }
        
    }
}



print(DatabaseConnection.getSharedInstance())
DatabaseConnection.getSharedInstance().connectDatabase()

print("---------------------------------------------------")

DatabaseConnection.getSharedInstance().POST(username: "Ramazan Amangeldin", email: "ramazan@gmail.com")
DatabaseConnection.getSharedInstance().POST(username: "Ulan Satybaldin", email: "ulan@gmail.com")


print("Database data:", DatabaseConnection.getSharedInstance().dict)

print("---------------------------------------------------")

print(DatabaseConnection.getSharedInstance().GET(username: "Ulan Satybaldin") ?? "Error")

print("---------------------------------------------------")

print(DatabaseConnection.getSharedInstance().GET(username: "Bekzhan Zhakas") ?? "Error")

