//
//  PlayerController.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 15.02.2025.
//

import Foundation

class PlayerController {
    
    //Change to Detective
    var detective: Detective? = nil
    
    //takes from detective
    var maxHealth = 0
    var maxSanity = 0
    
    //takes from detective when init
    var currentHealth = 0
    var currentSanity = 0
    
    //placeholders for items and artifacts
    var items = [Item]()
    //var artifacts = [String]()
    
    var allItemsForGame = [Item]()
    
    var knowledge = 0
    var communication = 0
    var tention = 0
    var strenght = 0
    var will = 0
    
    var actionPerRound: Int = 2
    
    var successfullResults = [5,6]
    
    var countOfSuccessfullResults: Int = 0
    
    //placeholder for territoty
    var territory: Place? = nil
    
    var concetration = 0
    var resource = 0
    
    func updateWithDetective(detective: Detective) {
        self.detective = detective
        self.maxHealth = detective.health
        self.maxSanity = detective.sanity
        self.currentHealth = maxHealth
        self.currentSanity = maxSanity
        self.knowledge = detective.knowledge
        self.communication = detective.communication
        self.tention = detective.tention
        self.strenght = detective.strenght
        self.will = detective.will
        self.territory = Place(name: detective.initialPlace, type: .city, monsters: [])
    }
    
    func updateWithItems(items: [Item]) {
        self.allItemsForGame = items
        self.items = items
    }
    
    var currentResults = [Int]()
    
    func getAvailableActions() -> [Action] {
        ActionManager.shared.detectiveActions
    }
    
    var actions = [Action]()
    
    func getItemsWithActions(gamePhase: GamePhase) -> [Item] {
        var tempItems: [Item] = []
        for item in items {
            
            if item.action != nil && !item.usedThisRound && item.action?.typeAction == gamePhase || item.action?.typeAction == .all{
                tempItems.append(item)
            }
        }
        return tempItems
    }
    
    func totalStatValue(for stat: String, player: PlayerController, gamePhase: GamePhase) -> Int {
        let baseValue: Int
        switch stat.lowercased() {
        case "knowledge": baseValue = player.knowledge
        case "communication": baseValue = player.communication
        case "tention": baseValue = player.tention
        case "strenght": baseValue = player.strenght
        case "will": baseValue = player.will
        default: return 0
        }
        
        let maxBoost = player.items
            .filter { $0.phaseUsage == gamePhase || $0.phaseUsage == .all }
            .compactMap { $0.statBoosts?[stat] }
            .max() ?? 0
        print("Your total stat is \(baseValue) + \(maxBoost)")
        return baseValue + maxBoost
    }
    
}
