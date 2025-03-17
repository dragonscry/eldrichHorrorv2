//
//  Actions.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 05.02.2025.
//
class ActionManager {
    static let shared = ActionManager()
    
    //TODO: needs to provide action for unique actions or item action
    private let actionMap: [String: Action] = [:]
    
    func getAction(for key: String?) -> Action? {
        guard let key = key else { return nil }
        return actionMap[key]
    }
}

enum GamePhase: String, Codable {
    case hero, encounter, combat, all
}

protocol Action {
    var name: String { get }
    var description: String { get }
    var typeAction: GamePhase { get }
    
    func execute(for player: PlayerController)
}

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
        
        var market = player.items.shuffled().prefix(4)
        
        let successResults = checkStats(stat: player.communication)
        
        print("You have \(successResults) points to use for buying an item.\n")
        
        for (index, item) in market.enumerated() {
            print("\(index + 1). \(item)")
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


