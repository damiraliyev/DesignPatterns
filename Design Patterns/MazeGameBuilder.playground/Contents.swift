//
//  MazeGameBuilder.swift
//
//
//  Created by Damir Aliyev on 19.02.2023.
//

import UIKit
 
protocol MazeBuilder {
    func addRoom(room: Room) -> Self
    func reset()
    func createMaze() -> Maze
}

class Maze1Builder: MazeBuilder {
    
    private var maze = Maze()
    
    
    func addRoom(room: Room) -> Self {
        maze.rooms[room.getRoomNo()] = room
        
        return self
    }
    
    func reset() {
        maze = Maze()
    }
    
    func createMaze() -> Maze {
        let result = maze
        reset()
        return result
    }
}


public class Maze {
    
    var rooms = [Int: Room]()
    
    public func roomNo(r: Int) -> Room {
        return rooms[r]!
    }
    
    func displayRooms() {
        for (key,value) in rooms {
            print(key, value.getRoomNo())
            print(value.getSide(direction: .NORTH))
            print(value.getSide(direction: .EAST))
            print(value.getSide(direction: .SOUTH))
            print(value.getSide(direction: .WEST))
        }
    }
}

public enum Direction {
    case NORTH
    case EAST
    case SOUTH
    case WEST
}

protocol RoomBuilder {
    func setNumber(roomNo: Int) -> Self
    func setSide(direction: Direction, wall: Wall) -> Self
    func createRoom() -> Room
}

class Room1Builder: RoomBuilder {
    
    private var roomNo: Int!
    
    private var sides = [Direction: Wall]()
    
    func setNumber(roomNo: Int) -> Self {
        self.roomNo = roomNo
        return self
    }
    
    func setSide(direction: Direction, wall: Wall) -> Self {
        sides[direction] = wall
        return self
    }
    
    
    func createRoom() -> Room {
        let room = Room(roomNo: roomNo, sides: sides)
        return room
    }
}



public class Room {
    
    var sides = [Direction: Wall]()
    private let roomNo: Int
    
    public init(roomNo: Int) {
        self.roomNo = roomNo
    }

    public func getSide(direction: Direction) -> Wall {
        return sides[direction]!
    }
    
    init(roomNo: Int, sides: [Direction: Wall]) {
        self.sides = sides
        self.roomNo = roomNo
    }
    
    func getRoomNo() -> Int {
        return roomNo
    }
    
    func enter() {
        print("Trying to enter to the roomr")
    }
}

protocol WallBuilder {
    var hasDoor: Bool { get set }
    func setRoom(room: Room) -> Self
    func createWall() -> Wall
}

class DoorWallBuilder: WallBuilder {
    
    private var rooms = [Room]()

    var hasDoor: Bool = true
    
    func setRoom(room: Room) -> Self {
        self.rooms.append(room)
        return self
    }
    
    func createWall() -> Wall {
        let doorWall = DoorWall(r1: rooms[0], r2: rooms[1])
        return doorWall
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


//    static func createMaze() -> Maze {
//        let aMaze = Maze()
//        let r1 = Room(roomNo: 1)
//        let r2 = Room(roomNo: 2)
//        let d = DoorWall(r1: r1, r2: r2)
//
//        r1.setSide(direction: Direction.NORTH, wall: d)
//        r1.setSide(direction: Direction.EAST, wall: Wall())
//        r1.setSide(direction: Direction.SOUTH, wall: Wall())
//        r1.setSide(direction: Direction.WEST, wall: Wall())
//
//        r2.setSide(direction: Direction.NORTH, wall: Wall())
//        r2.setSide(direction: Direction.EAST, wall: Wall())
//        r2.setSide(direction: Direction.SOUTH, wall: d)
//        r2.setSide(direction: Direction.WEST, wall: Wall())
//
//        aMaze.addRoom(r: r1)
//        aMaze.addRoom(r: r2)
//
//        return aMaze ;
//    }
    
    func createMaze() -> Maze {
        
        let mazeBuilder = Maze1Builder()

        let roomBuilder = Room1Builder()
    
        let doorWallBuilder = DoorWallBuilder()
        
        var r1 = Room(roomNo: 1)
        var r2 = Room(roomNo: 2)
        
        let doorWall = doorWallBuilder.setRoom(room: r1).setRoom(room: r2).createWall()
        
        r1 = roomBuilder.setNumber(roomNo: 1)
            .setSide(direction: .NORTH, wall: doorWall)
            .setSide(direction: .EAST, wall: Wall())
            .setSide(direction: .SOUTH, wall: Wall())
            .setSide(direction: .WEST, wall: Wall())
            .createRoom()
        
        r2 = roomBuilder.setNumber(roomNo: 2)
            .setSide(direction: .NORTH, wall: Wall())
            .setSide(direction: .EAST, wall: Wall())
            .setSide(direction: .SOUTH, wall: doorWall)
            .setSide(direction: .WEST, wall: Wall())
            .createRoom()
        
        let maze = mazeBuilder.addRoom(room: r1)
                   .addRoom(room: r2)
                   .createMaze()
        
        return maze
    }


let game1 = createMaze()

print(game1.displayRooms())


