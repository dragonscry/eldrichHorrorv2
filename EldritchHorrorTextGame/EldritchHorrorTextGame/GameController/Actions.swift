//
//  Actions.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 05.02.2025.
//
class ActionManager {
    static let shared = ActionManager()
    
    //private let uniqueActions: [String: Action] = []
    
//    func getUniqueAction(for detective: Detective) -> Action {
//        //return uniqueActions[detective.name] ?? RestAction() // Default action
//    }
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
    
    func execute(for detective: Detective)
}

struct RestAction: Action {
    var typeAction = ActionsType.heroAction
    var name = "Rest"
    var description = "Detective Rest and restore 1 health and 1 sanity"
    
    
    func execute(for detective: Detective) {
        print("\(detective.name) rests and regains health and sanity.")
    }
}

struct BuyItemAction: Action {
    var typeAction: ActionsType = .heroAction
    var name = "Buy Item"
    var description = "Player Buys item from shop"
    
    func execute(for detective: Detective) {
        print("\(detective.name) buys an item.")
    }
}
