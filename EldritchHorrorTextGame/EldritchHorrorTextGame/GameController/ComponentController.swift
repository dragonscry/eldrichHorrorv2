//
//  ComponentController.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 10.02.2025.
//

class ComponentController {
    
    let detectives: [String]
    
    let myths: [String]
    
    let monsters: [String]
    
    let bosses: [String]
    
    let items: [String]
    
    let spells: [String]
    
    let artifacts: [String]
    
    init(detectives: [String], myths: [String], monsters: [String], bosses: [String], items: [String], spells: [String], artifacts: [String]) {
        self.detectives = detectives
        self.myths = myths
        self.monsters = monsters
        self.bosses = bosses
        self.items = items
        self.spells = spells
        self.artifacts = artifacts
    }
    
}
