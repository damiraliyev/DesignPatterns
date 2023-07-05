import UIKit


protocol Cloneable {
    // It is required initializer
    init(_ prototype: Self)
    func copy() -> Self
}


public class Maze: Cloneable {
    
    private var rooms = [Int: Room]()
    
    // Main initializer 1
    init() {}
    
    // Main initializer 2
    init(rooms: [Int:Room]) {
        self.rooms = rooms
    }
    
    // Our required initializer calls one of our main initializers
    required convenience init(_ prototype: Maze) {
        //We call our second main initializer and pass our rooms, because it is
        // the main property of the game
        self.init(rooms: prototype.rooms)
    }
    
    public func addRoom(r: Room) {
        rooms[r.getRoomNo()] = r
    }
    
    public func roomNo(r: Int) -> Room {
        return rooms[r]!
    }
    
    func displayRooms() {
        for (key,value) in rooms {
            print(key, value.getRoomNo())
        }
    }
    
    func copy() -> Self {
        return Self.init(self)
    }
}

public enum Direction {
    case NORTH
    case EAST
    case SOUTH
    case WEST
}

public class Room {
    
    private var sides = [Direction: Wall]()
    private let roomNo: Int
    
    public init(roomNo: Int) {
        self.roomNo = roomNo
    }
    
    public func getSide(direction: Direction) -> Wall {
        return sides[direction]!
    }
    
    public func setSide(direction: Direction, wall: Wall) {
        sides[direction] = wall
    }
    
    func getRoomNo() -> Int {
        return roomNo
    }
    
    func enter() {
        print("Trying to enter to the roomr")
    }
    
}

public class Wall {
    
}

public class DoorWall: Wall {
    private let r1: Room
    private let r2: Room
    private var isOpen: Bool
    
    public init(r1: Room, r2: Room) {
        self.r1 = r1
        self.r2 = r2
        self.isOpen = false
    }
    
    func enter() {
        isOpen = true
        print("Entered")
    }
}

public class MazeGame {
    static func createMaze() -> Maze {
        let aMaze = Maze()
        let r1 = Room(roomNo: 1)
        let r2 = Room(roomNo: 2)
        let d = DoorWall(r1: r1, r2: r2)
        
        aMaze.addRoom(r: r1)
        aMaze.addRoom(r: r2)
        
        r1.setSide(direction: Direction.NORTH, wall: d)
        r1.setSide(direction: Direction.EAST, wall: Wall())
        r1.setSide(direction: Direction.SOUTH, wall: Wall())
        r1.setSide(direction: Direction.WEST, wall: Wall())
        
        r2.setSide(direction: Direction.NORTH, wall: Wall())
        r2.setSide(direction: Direction.EAST, wall: Wall())
        r2.setSide(direction: Direction.SOUTH, wall: d)
        r2.setSide(direction: Direction.WEST, wall: Wall())
        
        return aMaze ;
    }

}

let game1 = MazeGame.createMaze()

let game2 = game1.copy()


print("FIRST GAME")
print(game1.displayRooms())


print("-------------------------------------")
print("SECOND GAME")
print(game2.displayRooms())

print(game1 === game2)
