//
//  Territory.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 01.02.2025.
//

import Foundation


//type of territory
enum TerritoryType {
    case city, forest, sea
    
}

//struct for Place
struct Place {
    
    let name: String
    let type: TerritoryType
    let monsters: [Monster]
    
    
}

//struct for Monsters
struct Monster {
    let name: String
    var health: Int
    let damage: Int
    let brainDamage: Int
    let damageModifier: Int
    let brainModifier: Int
}
