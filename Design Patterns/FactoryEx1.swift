//
//  FactoryEx1.swift
//  
//
//  Created by Damir Aliyev on 25.02.2023.
//

class Appearance {
    let height: Int
    let auraColor: String
    let gender: String
    
    init(height: Int, auraColor: String, gender: String) {
        self.height = height
        self.auraColor = auraColor
        self.gender = gender
    }
}

class Ability {
    let name: String
    let damage: Int
    let manaCost: Int
    
    init(name: String, damage: Int, manaCost: Int) {
        self.name = name
        self.damage = damage
        self.manaCost = manaCost
    }
}

class Equipment {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Attribute {
    let strength: Int
    let agility: Int
    let intelligence: Int
    
    init(strength: Int, agility: Int, intelligence: Int) {
        self.strength = strength
        self.agility = agility
        self.intelligence = intelligence
    }
}

protocol Character {
    var name: String {get set}
    var appearance: Appearance {get set}
    var abilitites: [Ability] {get set}
    var equipment: [Equipment] {get set}
    var attributes: Attribute {get set}
}


protocol CharacterFactory {
    func createCharacter(name: String) -> Character
}


class Warrior: Character {
    
    var name: String
    
    var appearance: Appearance = Appearance(height: 195, auraColor: "red", gender: "male")
            
    var abilitites: [Ability] = [Ability(name: "BERSERKER'S RAGE", damage: 20, manaCost: 0),
                                 Ability(name: "WHIRLING AXES", damage: 90, manaCost: 60),
                                 Ability(name: "BATTLE TRANCE", damage: 50, manaCost: 0),
                                 Ability(name: "RAMPAGE", damage: 110, manaCost: 0)
                                ]
    
    var equipment: [Equipment] = [Equipment(name: "Axes"),
                                  Equipment(name: "Helmet"),
                                  Equipment(name: "Armor")
                                 ]
    
    var attributes: Attribute = Attribute(strength: 21, agility: 23, intelligence: 13)
    
    init(name: String) {
        self.name = name
    }
    
}

class WarriorFactory: CharacterFactory {
    func createCharacter(name: String) -> Character {
        return Warrior(name: name)
    }
}



class Mage: Character {
    
    var name: String
    
    var appearance: Appearance = Appearance(height: 175, auraColor: "blue", gender: "female")
    
    var abilitites: [Ability] = [Ability(name: "Crystal Nove", damage: 130, manaCost: 115),
                                 Ability(name: "Frostbite", damage: 150, manaCost: 125),
                                 Ability(name: "Arcane aura", damage: 50, manaCost: 0),
                                 Ability(name: "Freezing field", damage: 250, manaCost: 200)
                                ]
    
    var equipment: [Equipment] = [Equipment(name: "Ice staff"),
                                  Equipment(name: "Blue cape")
                                ]
    
    var attributes: Attribute = Attribute(strength: 17, agility: 16, intelligence: 16)
    
    init(name: String) {
        self.name = name
    }
    
    
}

class MageFactory: CharacterFactory {
    func createCharacter(name: String) -> Character {
        return Mage(name: name)
    }
}



class Archer: Character {
    var name: String
    
    var appearance: Appearance = Appearance(height: 180, auraColor: "Blue", gender: "Female")
    
    var abilitites: [Ability] = [Ability(name: "Frost Arrows", damage: 15, manaCost: 9),
                                 Ability(name: "Gust", damage: 50, manaCost: 70),
                                 Ability(name: "Multishot", damage: 100, manaCost: 70),
                                 Ability(name: "Marksmanship", damage: 200, manaCost: 0)
                                ]
    
    var equipment: [Equipment] = [Equipment(name: "Bow"),
                                  Equipment(name: "Arrows"),
                                  Equipment(name: "Dark blue cape")
                                ]
    
    var attributes: Attribute = Attribute(strength: 16, agility: 20, intelligence: 15)
    
    init(name: String) {
        self.name = name
    }
}

class ArcherFactory: CharacterFactory {
    func createCharacter(name: String) -> Character {
        return Archer(name: name)
    }
}


//New type of character
class Robot: Character {
    
    var name: String
    
    var appearance: Appearance =  Appearance(height: 170, auraColor: "Gray", gender: "Robot")
    
    
    var abilitites: [Ability] = [Ability(name: "Battery Assault", damage: 45, manaCost: 90),
                                 Ability(name: "Power Cogs", damage: 125, manaCost: 80),
                                 Ability(name: "Rocket Flare", damage: 120, manaCost: 40),
                                 Ability(name: "Hookshot", damage: 175, manaCost: 125)
                                ]
    
    var equipment: [Equipment] = [Equipment(name: "Mechanical Hook"),
                                  Equipment(name: "Iron Armor"),
                                ]
     
    
    var attributes: Attribute = Attribute(strength: 26, agility: 13, intelligence: 18)
    
    init(name: String) {
        self.name = name
    }
}

class RobotFactory: CharacterFactory {
    func createCharacter(name: String) -> Character {
        return Robot(name: name)
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
    
    func createCharacter(name: String) -> Character {
        factory.createCharacter(name: name)
    }
}

let warriorFactory = WarriorFactory()

let creator = CharacterCreator(factory: warriorFactory)

let trollWarlord = creator.createCharacter(name: "Troll Warlord")
print(trollWarlord.abilitites.first?.name)

let mageFactory = MageFactory()
creator.setFactory(factory: mageFactory)

let crystalMaiden = creator.createCharacter(name: "Crystal Maiden")
print(crystalMaiden.abilitites.first?.name)

let archerFactory = ArcherFactory()
creator.setFactory(factory: archerFactory)

let drowRanger = creator.createCharacter(name: "Drow Ranger")
print(drowRanger.abilitites.first?.name)

let robotFactory = RobotFactory()
creator.setFactory(factory: robotFactory)
let clockwerk = creator.createCharacter(name: "Clockwerk")
print(clockwerk.abilitites.first?.name)


