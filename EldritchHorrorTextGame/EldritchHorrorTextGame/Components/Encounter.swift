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

struct IncreaseStrength: Action {
    var name = "Increase Strength"
    var description = "You increase your strength by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.strenght += 1
        print("You became stronger!")
        print("Now your strength is \(player.strenght)")
    }
}

struct DecreaseStrength: Action {
    var name = "Decrease Strength"
    var description = "Your strength decreases by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.strenght -= 1
        print("You feel weaker!")
        print("Now your strength is \(player.strenght)")
    }
}

struct IncreaseKnowledge: Action {
    var name = "Increase Knowledge"
    var description = "You increase your knowledge by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.knowledge += 1
        print("Your wisdom grows!")
        print("Now your knowledge is \(player.knowledge)")
    }
}

struct DecreaseKnowledge: Action {
    var name = "Decrease Knowledge"
    var description = "Your knowledge decreases by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.knowledge -= 1
        print("You feel less wise!")
        print("Now your knowledge is \(player.knowledge)")
    }
}

struct IncreaseCommunication: Action {
    var name = "Increase Communication"
    var description = "You improve your communication skills by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.communication += 1
        print("You are more persuasive now!")
        print("Now your communication is \(player.communication)")
    }
}

struct DecreaseCommunication: Action {
    var name = "Decrease Communication"
    var description = "Your communication skills decrease by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.communication -= 1
        print("You struggle to express yourself!")
        print("Now your communication is \(player.communication)")
    }
}

struct IncreaseTension: Action {
    var name = "Increase Tension"
    var description = "Your tension increases by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.tention += 1
        print("You feel more stressed!")
        print("Now your tension is \(player.tention)")
    }
}

struct DecreaseTension: Action {
    var name = "Decrease Tension"
    var description = "You relax, reducing your tension by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.tention -= 1
        print("You feel more at ease!")
        print("Now your tension is \(player.tention)")
    }
}

struct IncreaseWill: Action {
    var name = "Increase Will"
    var description = "Your willpower increases by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.will += 1
        print("Your determination strengthens!")
        print("Now your will is \(player.will)")
    }
}

struct DecreaseWill: Action {
    var name = "Decrease Will"
    var description = "Your willpower weakens by 1"
    var typeAction = GamePhase.encounter
    
    func execute(for player: PlayerController) {
        player.will -= 1
        print("You feel less determined!")
        print("Now your will is \(player.will)")
    }
}

