//
//  Monsters.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 15.02.2025.
//

import Foundation

//struct for Monsters
struct Monster: Codable {
    let name: String
    var health: Int
    let healthDamage: Int
    let brainDamage: Int
    let healthDamageModifier: Int
    let brainDamageModifier: Int
}


