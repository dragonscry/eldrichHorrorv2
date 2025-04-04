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
    
    let monsters: [Monster]
    
    
    let rawItems: [RawItem]
    
    var items: [Item] = []
    
    var encounters: [EncounterTerritory] = []
    var rawEncounters: [EncounterTerritoryRaw] = []
    
    init(myths: [String]) {
        self.detectives = Bundle.main.decode(from: "detective") ?? []
        self.myths = myths
        self.monsters = Bundle.main.decode(from: "monsters") ?? []
        //self.bosses = bosses
        self.rawItems = Bundle.main.decode(from: "items") ?? []
        self.rawEncounters = Bundle.main.decode(from: "encounters") ?? []
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
                phaseUsage: GamePhase(rawValue: rawItem.phaseUsage ?? "all"),
                isSingleUse: rawItem.isSingleUse
            )
            
            // Map action key to action
            if let actionKey = rawItem.actionKey {
                item.action = ActionManager.shared.getAction(for: actionKey)
            }
            
            items.append(item)
        }
    }
    
    func downloadEncounters() {
        for rawEncounter in rawEncounters {
            var encounterTerritory = EncounterTerritory(
                story: rawEncounter.story,
                testStat: rawEncounter.testStat,
                difficulty: rawEncounter.difficulty,
                successText: rawEncounter.successText,
                failureText: rawEncounter.failureText,
                territoryType: rawEncounter.territoryType
                )
            
            // Map action key to action
            encounterTerritory.successAction = ActionManager.shared.getAction(for: rawEncounter.successAction)
            encounterTerritory.failedAction = ActionManager.shared.getAction(for: rawEncounter.failedAction)
            
            encounters.append(encounterTerritory)
        }
    }
    
}
