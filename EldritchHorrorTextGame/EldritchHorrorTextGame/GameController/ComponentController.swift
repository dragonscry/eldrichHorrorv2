//
//  ComponentController.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 10.02.2025.
//

import Foundation

class ComponentController {
    
    let detectives: [Detective]
    
    let myths: [String]
    
    let monsters: [String]
    
    let bosses: [String]
    
    let items: [String]
    
    let spells: [String]
    
    let artifacts: [String]
    
    init(myths: [String], monsters: [String], bosses: [String], items: [String], spells: [String], artifacts: [String]) {
        self.detectives = Bundle.main.decode(from: "detective") ?? []
        self.myths = myths
        self.monsters = monsters
        self.bosses = bosses
        self.items = items
        self.spells = spells
        self.artifacts = artifacts
    }
    
}
