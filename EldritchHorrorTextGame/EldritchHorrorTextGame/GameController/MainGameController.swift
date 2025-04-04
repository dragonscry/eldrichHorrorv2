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
    var monsterChance = 100
    
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
    
    func combat(monsters: [Monster], player: PlayerController) {
        gamePhase = .combat
        
        print("Combat begins!")
        
        
        for monster in monsters {
            print("You going to fight with \(monster.name)")
            var currentMonster = monster
            //Checking Will
            print("Checking Will...")
            let willResult = checkStats(stat: "will", for: player, gamePhase: gamePhase, difficulty: monster.brainDamageModifier)
            let monsterBrainDamage = monster.brainDamage - willResult.1
            if monsterBrainDamage > 0 {
                print("Player takes \(monsterBrainDamage)")
                player.currentSanity -= monsterBrainDamage
                print("Player current sanity is \(player.currentSanity)")
            } else {
                print("Players sanity is safe!")
            }
            
            //Checking Strenght
            while currentMonster.health > 0 {
                print("Checking Strength...")
                let strenghtResults = checkStats(stat: "strength", for: player, gamePhase: gamePhase, difficulty: monster.healthDamageModifier)
                player.countOfSuccessfullResults = strenghtResults.1
                print("You have total \(player.countOfSuccessfullResults) to hit monster")
                
                let monsterHealthDamage = monster.healthDamage - strenghtResults.1 
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
        var results = checkStats(stat: encounter.testStat, for: player, gamePhase: gamePhase, difficulty: encounter.difficulty)
        
        if results.0 {
            print(encounter.successText)
            encounter.successAction?.execute(for: player)
        } else {
            printTextWithDelay(encounter.failureText)
            encounter.failedAction?.execute(for: player)
        }
    }
}
