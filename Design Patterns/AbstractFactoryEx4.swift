//
//  AbstractFactoryEx4.swift
//  
//
//  Created by Damir Aliyev on 25.02.2023.
//

protocol Weapon {
    var type: String {get}
    var damage: Int {get}
    var speed: Int {get}
    var range: Int {get}
}

class Sword: Weapon {
    
    var type: String = "Sword"
    
    var damage: Int = 100
    
    var speed: Int = 50
    
    var range: Int = 30
    
}

class Staff: Weapon {
    
    var type: String = "Staff"
    
    var damage: Int = 80
    
    var speed: Int = 50
    
    var range: Int = 70
    
}

class Bow: Weapon {
    
    var type: String = "Bow"
    
    var damage: Int = 60
    
    var speed: Int = 70
    
    var range: Int = 85
    
}

protocol Character {
    var name: String {get}
    var characterClass: String {get}
    var weapon: Weapon? {get}
    var health: Int {get}
    var mana: Int {get}
    
    func setWeapon(weapon: Weapon)
}

class Warrior: Character {
    
    var name: String
    
    var characterClass: String = "Warrior"
    
    var weapon: Weapon? = nil
    
    var health: Int
    
    var mana: Int
    
    init(name: String, health: Int, mana: Int) {
        self.name = name
        self.health = health
        self.mana = mana
    }
    
    func setWeapon(weapon: Weapon) {
        self.weapon = weapon
    }
    
}

class Mage: Character {
    var name: String
    
    var characterClass: String = "Mage"
    
    var weapon: Weapon? = nil
    
    var health: Int
    
    var mana: Int
    
    init(name: String, health: Int, mana: Int) {
        self.name = name
        self.health = health
        self.mana = mana
    }
    
    func setWeapon(weapon: Weapon) {
        self.weapon = weapon
    }
}

class Archer: Character {
    
    var name: String
    
    var characterClass: String = "Archer"
    
    var weapon: Weapon? = nil
    
    var health: Int
    
    var mana: Int
    
    init(name: String, health: Int, mana: Int) {
        self.name = name
        self.health = health
        self.mana = mana
    }
    
    func setWeapon(weapon: Weapon) {
        self.weapon = weapon
    }
}


protocol CharacterFactory {
    func createCharacter() -> Character
    func createWeapon() -> Weapon
}

class WarriorSwordFactory: CharacterFactory {
    func createCharacter() -> Character {
        return Warrior(name: "Dragon Knight", health: 500, mana: 300)
    }

    func createWeapon() -> Weapon {
        return Sword()
    }
}

class MageStaffFactory: CharacterFactory {
    func createCharacter() -> Character {
        return Mage(name: "Crystal Maiden", health: 380, mana: 500)
    }
    
    func createWeapon() -> Weapon {
        return Staff()
    }
}

class ArcherBowFactory: CharacterFactory {
    func createCharacter() -> Character {
        return Archer(name: "Drow Ranger", health: 420, mana: 400)
    }
    
    func createWeapon() -> Weapon {
        return Bow()
    }
}


class CharacterCreator {
    
    private var factory: CharacterFactory
    
    init(factory: CharacterFactory) {
        self.factory = factory
    }
    
    func setFactory(factory: CharacterFactory) {
        self.factory = factory
    }
    
    func createCharacter() -> Character {
        let weapon = factory.createWeapon()
        let character = factory.createCharacter()
        character.setWeapon(weapon: weapon)
        
        return character
    }
}


let warriorSwordFactory = WarriorSwordFactory()

let creator = CharacterCreator(factory: warriorSwordFactory)


let warrior = creator.createCharacter()
print(warrior.name)

