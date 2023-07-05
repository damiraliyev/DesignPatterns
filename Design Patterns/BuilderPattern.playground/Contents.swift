import Foundation
import UIKit
class House {
    let floorType: String
    let roofType: String
    let wallType: String
    let windowsNumber: Int
    
    init(floortType: String, roofType: String, wallType: String, windowsNumber: Int) {
        self.floorType = floortType
        self.roofType = roofType
        self.wallType = wallType
        self.windowsNumber = windowsNumber
    }
}


protocol HouseBuilder {
    func buildFloor(type: String) -> Self
    func buildRoof(type: String) -> Self
    func buildWall(type: String) -> Self
    func buildWindows(count: Int) -> Self
    func getResult() -> House
}


class WoodHouseBuilder: HouseBuilder {
    
    private var floorType: String = "wood"
    
    private var roofType: String = "wood"
    
    private var wallType: String = "wood"
    
    private var windowsNumber: Int = 4
    
    func buildFloor(type: String) -> Self {
        floorType = type
        return self
    }
    
    func buildRoof(type: String) -> Self {
        roofType = type
        return self
    }
    
    func buildWall(type: String) -> Self {
        wallType = type
        return self
    }
    
    func buildWindows(count: Int) -> Self {
        windowsNumber = count
        return self
    }
    
    func getResult() -> House {
        return House(floortType: floorType, roofType: roofType, wallType: wallType, windowsNumber: windowsNumber)
    }
}


class Director {
    var builder: HouseBuilder
    
    init(builder: HouseBuilder) {
        self.builder = builder
    }
    
    func constructWoodHouse() -> House {
        return builder.buildFloor(type: "Wood").buildWall(type: "wood").buildRoof(type: "wood").buildWindows(count: 4).getResult()
    }
}

let woodHouseBuilder = WoodHouseBuilder()
let director = Director(builder: woodHouseBuilder)

let woodHouse = director.constructWoodHouse()

}
