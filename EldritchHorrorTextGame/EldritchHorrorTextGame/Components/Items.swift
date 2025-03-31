//
//  Items.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 05.03.2025.
//

struct Item {
    let name: String
    let description: String
    let type: String
    let cost: Int
    let actionKey: String?
    var action: Action? = nil  // Will be assigned after decoding if actionKey matches
    
    let statBoosts: [String: Int]?
    let phaseUsage: GamePhase?
    let isSingleUse: Bool
    var usedThisRound: Bool = false // Tracks if the item was used in the current round
    
    func itemDesctiption() {
        print("Name: \(name)")
        print("Description: \(description)")
        print("Type: \(type)")
        print("💰: \(cost)")
        
        if let action {
            print("Action: \(action.description)")
            print("Can be used in \(action.typeAction.description)")
            
        }
        
        if let statBoosts {
            print("Stat boosts:")
            for (stat, boost) in statBoosts {
                print("\(stat): \(boost)")
            }
        }
        
        print("Can be used in \(phaseUsage?.description ?? "any phase")")
        if isSingleUse {
            print("Can be used just once")
        } else {
            print("Can be used once per round")
        }
        
    }
}

struct RawItem: Decodable {
    let name: String
    let description: String
    let type: String
    let cost: Int
    let actionKey: String?
    
    let statBoosts: [String: Int]?
    let phaseUsage: String? // Assuming GamePhase is a String enum for simplicity
    let isSingleUse: Bool
}
