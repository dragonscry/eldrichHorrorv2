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
        print("\(player.detective?.name ?? "unknown") rests and regains health and sanity.")
    }
}

struct BuyItemAction: Action {
    var typeAction: GamePhase = .hero
    var name = "Buy Item"
    var description = "Player Buys item from shop"
    
    func execute(for player: PlayerController) {
        
        var market = player.allItemsForGame.shuffled().prefix(4)
        
        let successResults = checkStats(stat: player.communication, for: player.successfullResults)
        
        print("You have \(successResults.0) points to use for buying an item.\n")
        
        for (index, item) in market.enumerated() {
            print("\(index + 1). \(item.name) \(item.cost)")
        }
        
        
        print("\(player.detective?.name ?? "unknown") buys an item.")
    }
}

struct PrepareConcetration: Action {
    var name = "Prepare Concetration"
    
    var description = "Increase player's concetration by 1"
    
    var typeAction = GamePhase.hero
    
    func execute(for player: PlayerController) {
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
        if player.resource >= 2 {
            print("You have maximum resource now!")
        } else {
            player.resource += 1
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
        print("There is items in your bag with aviable actions")
    }
    
}
