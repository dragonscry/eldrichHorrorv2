//
//  Detective.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 01.02.2025.
//

struct Detective: Codable {
    let name: String
    let job: String
    let description: String
    
    let health: Int
    let sanity: Int
    
    let knowledge: Int
    let communication: Int
    let tention: Int
    let strenght: Int
    let will: Int
    
    //placeHolder
    let initialPlace: String
    let equipment: [String]
}

//MARK: Player Actions
struct RestAction: Action {
    var typeAction = GamePhase.hero
    var name = "Rest"
    var description = "Detective Rest and restore 1 health and 1 sanity"
    
    
    func execute(for player: PlayerController) {
        player.actionPerRound -= 1
        print("\(player.detective?.name ?? "unknown") rests and regains health and sanity.")
    }
}

struct BuyItemAction: Action {
    var typeAction: GamePhase = .hero
    var name = "Buy Item"
    var description = "Player Buys item from shop"
    
    func execute(for player: PlayerController) {
        player.actionPerRound -= 1
        var market = Array(player.allItemsForGame.shuffled().prefix(4))
        
        let successResults = checkStats(stat: player.communication, for: player.successfullResults)
        var points = successResults.1
        
        print("You have \(points) points to use for buying an item.\n")
        
        while player.resource > 0 {
            print("Do you want to use your resource to buy an item? (y/n)")
            
            if let input = readLine(), input == "y" {
                UseResource().execute(for: player)
                points += 1
                print("You use resource and gain +1 point.\n")
                print("You have \(points) points to use for buying an item.\n")
            } else if let input = readLine(), input == "n" {
                break
            } else {
                print("Invalid input, please try again.\n")
            }
            
        }
        
        while points > 0 {
            print("Market items:")
            for (index, item) in market.enumerated() {
                print("\(index + 1). \(item.name) - Cost: \(item.cost)")
            }
            print("Type 'info <number>' to get item details or 'buy <number>' to purchase an item. Type 'exit' to stop shopping.")
            
            if let input = readLine() {
                let components = input.split(separator: " ")
                
                if components.count == 2 {
                    let command = components[0]
                    if let itemNumber = Int(components[1]), itemNumber > 0, itemNumber <= market.count {
                        let selectedItem = market[itemNumber - 1]
                        
                        switch command.lowercased() {
                        case "info":
                            print("\n\(selectedItem.name): \(selectedItem.description)\n")
                            
                        case "buy":
                            if points >= selectedItem.cost {
                                points -= selectedItem.cost
                                player.items.append(selectedItem)
                                market.remove(at: itemNumber - 1)
                                print("You bought \(selectedItem.name)! Remaining points: \(points)\n")
                            } else {
                                print("Not enough points to buy \(selectedItem.name).\n")
                            }
                            
                        default:
                            print("Unknown command.\n")
                        }
                    } else {
                        print("Invalid item number.\n")
                    }
                } else if input.lowercased() == "exit" {
                    print("Exiting market.\n")
                    break
                } else {
                    print("Invalid command.\n")
                }
            }
        }
        
        print("Finished shopping.")
    }
}

struct PrepareConcetration: Action {
    
    var name = "Prepare Concetration"
    
    var description = "Increase player's concetration by 1"
    
    var typeAction = GamePhase.hero
    
    func execute(for player: PlayerController) {
        player.actionPerRound -= 1
        if player.concetration >= 2 {
            print("You have maximum concetration now!")
        } else {
            player.concetration += 1
            print("You have now \(player.concetration) now!")
        }
    }
}

struct PrepareResource: Action {
    var name = "Prepare Resource"
    
    var description = "Increase player's resource by 1"
    
    var typeAction = GamePhase.hero
    
    func execute(for player: PlayerController) {
        player.actionPerRound -= 1
        if player.resource >= 2 {
            print("You have maximum resource now!")
        } else {
            player.resource += 1
            print("You find resource. Now you have \(player.resource)")
        }
    }
}

struct UseResource: Action {
    
    var name = "Use Resource"
    var typeAction: GamePhase = .all
    var description = "Use 1 resource to increase health/sanity by 1 or made success by 1 when buying item"
    
    func execute(for player: PlayerController) {
        if player.resource > 0 {
            player.resource -= 1
            print(player.resource > 0 ? "You used resource. Now you have \(player.resource)" : "You used resource. Now you have no resorce!")
        } else {
            print("You have no resource!")
        }
    }
}

struct UseItem: Action {
    var name = "Use Item"
    var typeAction: GamePhase = .all
    var description: String = "Open item bag and choose one item"
    
    func execute(for player: PlayerController) {
        player.actionPerRound -= 1
        print("There is items in your bag with aviable actions")
    }
    
}
