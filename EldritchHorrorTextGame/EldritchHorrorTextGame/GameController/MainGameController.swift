//
//  MainGameController.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 03.02.2025.
//


enum GamePhase: String, Codable {
    case hero, encounter, combat, all
    
    var description: String {
        switch self {
        case .hero:
            return "The hero prepares for the adventure, gathering resources and planning their next move."
        case .encounter:
            return "An encounter phase where unexpected events challenge the hero’s abilities."
        case .combat:
            return "A battle phase where the hero fights against enemies, testing their strength and skills."
        case .all:
            return "A phase that applies to all aspects of the game."
        }
    }
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
    
    func createPlaces(monsters: [Monster]) -> [Place] {
        let cityNames = [
            "Dark Alley", "Haunted Mansion", "Marketplace", "Abandoned Warehouse", "Old Cathedral",
            "Silent Library", "Police Station", "Crowded Bazaar", "Theater of Shadows", "Crimson Square"
        ]
        
        let forestNames = [
            "Whispering Woods", "Ancient Ruins", "Enchanted Grove", "Mystic Glade", "Fangthorn Thicket",
            "Moonlit Clearing", "Silent Hollow", "Emerald Canopy", "Rootbound Path", "Cursed Copse"
        ]
        
        let seaNames = [
            "Abyssal Shore", "Sunken Grotto", "Pirate Cove", "Ghost Ship", "Siren's Rock",
            "Mariner's Rest", "Tidepool Caverns", "Whirlpool Basin", "Drowned Reef", "Blackwater Bay"
        ]
        
        let territoryNames: [TerritoryType: [String]] = [
            .city: cityNames,
            .forest: forestNames,
            .sea: seaNames
        ]
        
        var places: [Place] = []
        
        for type in TerritoryType.allCases {
            guard var names = territoryNames[type], !names.isEmpty else { continue }
            
            let randomIndex = Int.random(in: 0..<names.count)
            let placeName = names.remove(at: randomIndex)
            
            // Adjust monster chance with portal modifier
            let adjustedMonsterChance = min(100, monsterChance + Int(Double(monsterChance) * Double(portalChance) / 100.0))
            
            var placeMonsters: [Monster] = []
            var currentChance = adjustedMonsterChance
            
            while currentChance > 0 {
                if Int.random(in: 1...100) <= currentChance {
                    if let randomMonster = monsters.randomElement() {
                        placeMonsters.append(randomMonster)
                    }
                }
                currentChance -= 100
            }
            
            let hasPortal = Int.random(in: 1...100) <= portalChance
            
            let place = Place(
                name: placeName,
                type: type,
                monsters: placeMonsters,
                portal: hasPortal
            )
            
            places.append(place)
        }
        
        return places
    }

    
    func createPlaces() -> [Place] {
        let placeNames = ["Dark Alley", "Whispering Woods", "Abyssal Shore"]
        let placeTypes: [TerritoryType] = [.city, .forest, .sea]
        
        var places: [Place] = []
        for i in 0..<3 {
            let hasPortal = Int.random(in: 1...100) <= portalChance
            let hasMonster = Int.random(in: 1...100) <= monsterChance
            
            let monsters: [Monster] = []
            
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
        
        if player.territory?.type == .city {
            availableActions.append(BuyItemAction())
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
    
    
    
    func combat(monsters: [Monster], player: PlayerController) {
        gamePhase = .combat
        
        print("Combat begins!")
        
        for monster in monsters {
            var currentMonster = monster
            //Checking Will
            var playersTotalWill = player.totalStatValue(for: "will", player: player)
            playersTotalWill -= monster.brainDamageModifier
            print("Checking Will...")
            let willResult = checkStats(howManyRollsForStat: playersTotalWill, for: player)
            let monsterBrainDamage = monster.brainDamage - willResult.1
            if monsterBrainDamage > 0 {
                print("Player takes \(monsterBrainDamage)")
                player.currentSanity -= monsterBrainDamage
                print("Player current sanity is \(player.currentSanity)")
            } else {
                print("Players sanity is safe!")
            }
            
            //Checking Strenght
            while monster.health > 0 {
                var playersTotalStrength = player.totalStatValue(for: "strenght", player: player)
                playersTotalStrength -= monster.healthDamageModifier
                print("Checking Strength...")
                let strenghtResults = checkStats(howManyRollsForStat: playersTotalStrength, for: player)
                player.countOfSuccessfullResults = strenghtResults.1
                print("You have total \(player.countOfSuccessfullResults) to hit monster")
                selectAction(for: player)
                
                let itemWithAction = player.getItemsWithActions(gamePhase: .combat)
                if !itemWithAction.isEmpty {
                    player.selectItemAction(for: itemWithAction)
                }
                
                let monsterHealthDamage = strenghtResults.1 - monster.healthDamage
                if monsterHealthDamage > 0 {
                    print("Player takes \(monsterHealthDamage)")
                    player.currentHealth -= monsterHealthDamage
                    print("Player current health is \(player.currentHealth)")
                    print("Player hit for \(strenghtResults.1)")
                    currentMonster.health -= strenghtResults.1
                } else {
                    print("Player hit for \(strenghtResults.1)")
                    currentMonster.health -= strenghtResults.1
                }
                
                if currentMonster.health <= 0 {
                    print("Monster is defeated!")
                } else {
                    print("Monster Current Health is \(currentMonster.health)")
                }
            }
            
        }
    }
    
    func encounter(encounter: EncounterTerritory, player: PlayerController){
        gamePhase = .encounter
        print("You encounter with something!")
        
        print(encounter.story)
        print("Checking your stat \(encounter.testStat)")
        let countOfStat = max(1, player.totalStatValue(for: encounter.testStat, player: player) - encounter.difficulty)
        var results = checkStats(howManyRollsForStat: countOfStat, for: player)
        
        if results.0 {
            print(encounter.successText)
            encounter.successAction?.execute(for: player)
        } else {
            let itemWithAction = player.getItemsWithActions(gamePhase: .encounter)
            if !itemWithAction.isEmpty {
                print("Do you want to use item? (y/n)")
                let input = readLine()?.lowercased()
                if input == "y" {
                    player.selectItemAction(for: itemWithAction)
                } else if input == "n" {
                    print("Item will not be used")
                } else {
                    print("Invalid input. Item will not be used")
                }
            }
            
            let newResult = getSuccessfullResultsCount(from: player.currentResults, playerSuccessfullResults: player.successfullResults)
            if newResult > 0 {
                printTextWithDelay(encounter.successText)
                encounter.successAction?.execute(for: player)
            } else {
                printTextWithDelay(encounter.failureText)
                encounter.failedAction?.execute(for: player)
            }
        }
    }
}
