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

enum ActionsType {
    case heroAction
    case encaunter
    case combat
    case all
}

protocol Action {
    var name: String { get }
    var description: String { get }
    var typeAction: ActionsType { get }
    
    func execute(for player: PlayerController)
}

struct RestAction: Action {
    var typeAction = ActionsType.heroAction
    var name = "Rest"
    var description = "Detective Rest and restore 1 health and 1 sanity"
    
    
    func execute(for player: PlayerController) {
        print("\(player.detective?.name ?? "unknown") rests and regains health and sanity.")
    }
}

struct BuyItemAction: Action {
    var typeAction: ActionsType = .heroAction
    var name = "Buy Item"
    var description = "Player Buys item from shop"
    
    func execute(for player: PlayerController) {
        print("\(player.detective?.name ?? "unknown") buys an item.")
    }
}
