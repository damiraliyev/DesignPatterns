//
//  StrategyAssignment.swift
//  
//
//  Created by Damir Aliyev on 26.04.2023.
//

protocol Weapon {
    func attack()
}

class Sword: Weapon {
    func attack() {
        print("Slashing with a sword.")
    }
}

class Axe: Weapon {
    func attack() {
        print("Chopping with an axe.")
    }
}

class BowAndArrow: Weapon {
    func attack() {
        print("Shooting with a bow and arrow.")
    }
}

class MagicSpell: Weapon {
    func attack() {
        print("Expelliarmus.")
    }
}

class Character {
    private var weapon: Weapon

    init(weapon: Weapon) {
        self.weapon = weapon
    }

    func attackEnemy() {
        weapon.attack()
    }

    func changeWeapon(weapon: Weapon) {
        self.weapon = weapon
    }
}

let sword = Sword()

let character = Character(weapon: sword)

character.attackEnemy()
//Output: Slashing with a sword.

let axe = Axe()
character.changeWeapon(weapon: axe)
character.attackEnemy()
//Output: Chopping with an axe.

let bowAndArrow = BowAndArrow()
character.changeWeapon(weapon: bowAndArrow)
character.attackEnemy()
//Output: Shooting with a bow and arrow.

let magicSpell = MagicSpell()
character.changeWeapon(weapon: magicSpell)
character.attackEnemy()
//Output: Expelliarmus.
