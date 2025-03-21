//
//  MainGameController.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 03.02.2025.
//


enum GamePhase: String, Codable {
    case hero, encounter, combat, all
}

class MainGameController {
    
    var playerSelectedTerritory = false
    
    // how many percent portal appear in territory
    var portalChance = 20
    
    // how many percent monster appear in territory
    var monsterChance = 10
    
    //what is round now
    var roundCounter = 1
    
    
    var gamePhase: GamePhase = .hero
    
    //TODO: Update to make different places!
    func createPlaces() -> [Place] {
        let placeNames = ["Dark Alley", "Whispering Woods", "Abyssal Shore"]
        let placeTypes: [TerritoryType] = [.city, .forest, .sea]
        
        var places: [Place] = []
        
        for i in 0..<3 {
            let hasPortal = Int.random(in: 1...100) <= portalChance
            let hasMonster = Int.random(in: 1...100) <= monsterChance
            
            let monsters: [Monster] = hasMonster ? [Monster(name: "Horrific Spawn")] : []
            
            let place = Place(
                name: placeNames[i],
                type: placeTypes[i],
                monsters: monsters,
                portal: hasPortal
            )
            
            places.append(place)
        }
        
        return places
    }
    
    func selectAction(for player: PlayerController) {
        var availableActions = player.getAvailableActions().filter { action in
            action.typeAction == self.gamePhase
        }
        
        let aviableItems = player.getItemsWithActions(gamePhase: self.gamePhase)
        
        if !aviableItems.isEmpty {
            availableActions.append(UseItem())
        }
        
        while player.actionPerRound > 0 {
            print("You can make \(player.actionPerRound) action(s)!")
            
            
            print("\nChoose an action:")
            for (index, action) in availableActions.enumerated() {
                print("\(index + 1). \(action.name)")
            }
            
            print("\nEnter the number of your action:")
            
            if let input = readLine(), let choice = Int(input),
               choice > 0, choice <= availableActions.count {
                let selectedAction = availableActions[choice - 1]
                if selectedAction.name == "Use Item" {
                    selectedAction.execute(for: player)
                    player.selectItemAction(for: aviableItems)
                    availableActions.remove(at: choice - 1)
                } else {
                    selectedAction.execute(for: player)
                    availableActions.remove(at: choice - 1)
                }
                
            } else {
                print("Invalid choice. Try again.")
                continue
            }
        }

    }
    
    
    
    func combat(){}
    
    func encounter(){}
}
