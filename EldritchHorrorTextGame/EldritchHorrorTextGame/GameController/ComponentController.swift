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
    
//    let bosses: [String]
    
    let rawItems: [RawItem]
    
    var items: [Item] = []
    
//    let spells: [String]
    
//    let artifacts: [String]
    
    init(myths: [String], monsters: [String]) {
        self.detectives = Bundle.main.decode(from: "detective") ?? []
        self.myths = myths
        self.monsters = monsters
        //self.bosses = bosses
        self.rawItems = Bundle.main.decode(from: "items") ?? []
//        self.spells = spells
       // self.artifacts = artifacts
    }
    
    func downloadItems() {
        for rawItem in rawItems {
            var item = Item(
                name: rawItem.name,
                description: rawItem.description,
                type: rawItem.type,
                cost: rawItem.cost,
                actionKey: rawItem.actionKey,
                statBoosts: rawItem.statBoosts,
                phaseUsage: GamePhase(rawValue: rawItem.phaseUsage ?? ""),
                isSingleUse: rawItem.isSingleUse
            )
            
            // Map action key to action
            if let actionKey = rawItem.actionKey {
                item.action = ActionManager.shared.getAction(for: actionKey)
            }
            
            items.append(item)
        }
    }
    
}
