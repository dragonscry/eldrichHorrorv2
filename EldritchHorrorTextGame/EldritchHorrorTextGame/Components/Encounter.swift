//
//  Encounter.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 22.02.2025.
//

import Foundation

struct EncounterTerritoryRaw: Codable {
    let story: String
    let testStat: String
    let difficulty: Int
    let successText: String
    let failureText: String
    let territoryType: TerritoryType
    let successAction: String
    let failedAction: String
}

struct EncounterTerritory {
    let story: String
    let testStat: String
    let difficulty: Int
    let successText: String
    let failureText: String
    let territoryType: TerritoryType
    var successAction: Action? = nil // Will be assigned after decoding if actionKey matches
    var failedAction: Action? = nil // Will be assigned after decoding if actionKey matches
}

