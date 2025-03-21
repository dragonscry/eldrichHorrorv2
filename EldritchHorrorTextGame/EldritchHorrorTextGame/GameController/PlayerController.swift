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
    }
    
    var currentResults = [Int]()
    
    func getAvailableActions() -> [Action] {
        ActionManager.shared.detectiveActions
    }
    
    var actions = [Action]()
    
    func getItemsWithActions(gamePhase: GamePhase) -> [Item] {
        var tempActions: [Item] = []
        for item in allItemsForGame {
            
            if item.action != nil && !item.usedThisRound && item.action?.typeAction == gamePhase{
                tempActions.append(item)
            }
        }
        return tempActions
    }
    
    func selectItemAction(for items: [Item]) {
        // Display items with actions
        print("\nSelect an item to use:")
        for (index, item) in items.enumerated() {
            print("\(index + 1). \(item.name) - \(item.action?.name ?? "No action")")
        }
        
        // Read user input
        print("\nEnter the number of the item to use:")
        if let input = readLine(), let choice = Int(input),
           choice > 0, choice <= items.count {
            
            let selectedItem = items[choice - 1]
            
            if let itemIndex = self.allItemsForGame.firstIndex(where: { $0.name == selectedItem.name }) {
                
                // Execute item action
                self.allItemsForGame[itemIndex].action?.execute(for: self)
                
                // Handle single-use items
                if self.allItemsForGame[itemIndex].isSingleUse {
                    self.allItemsForGame.remove(at: itemIndex)
                    print("\(selectedItem.name) has been used and removed from your inventory.")
                    print("THERE IS ALL PLAYER ITEMS: \(self.items)")
                } else {
                    self.allItemsForGame[itemIndex].usedThisRound = true
                    print("\(selectedItem.name) has been used this round.")
                }
            }
            
        } else {
            print("Invalid choice. Try again.")
            selectItemAction(for: items)  // Retry on invalid input
        }
    }
    
}
