//
//  Actions.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 05.02.2025.
//

protocol Action {
    var name: String { get }
    var description: String { get }
    
    func execute(for detective: Detective)
}

struct RestAction: Action {
    let name = "Rest"
    var description = "Detective Rest and restore 1 health and 1 sanity"
    
    
    func execute(for detective: Detective) {
        print("\(detective.name) rests and regains health and sanity.")
    }
}

struct BuyItemAction: Action {
    let name = "Buy Item"
    var description = "Player Buys item from shop"
    
    func execute(for detective: Detective) {
        print("\(detective.name) buys an item.")
    }
}
