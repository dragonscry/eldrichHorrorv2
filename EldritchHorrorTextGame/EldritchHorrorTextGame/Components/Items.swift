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
    var usedThisRound: Bool = false  // Tracks if the item was used in the current round
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
