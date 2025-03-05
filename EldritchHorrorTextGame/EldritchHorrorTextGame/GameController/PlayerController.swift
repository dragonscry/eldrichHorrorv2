//
//  PlayerController.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 15.02.2025.
//

import Foundation

class PlayerController {
    
    //Change to Detective
    var detective: Detective
    
    //takes from detective
    let maxHealth: Int
    let maxSanity: Int
    
    //takes from detective when init
    var currentHealth: Int
    var currentSanity: Int
    
    //placeholders for items and artifacts
    var items = [String]()
    var artifacts = [String]()
    var stances = [String]()
    
    var knowledge: Int
    var communication: Int
    var tention: Int
    var strenght: Int
    var will: Int
    
    var successfullResults = [5,6]
    
    //placeholder for territoty
    var territory: Place
    
    init(detective: Detective) {
        self.detective = detective
        self.maxHealth = detective.health
        self.maxSanity = detective.sanity
        self.currentHealth = maxHealth
        self.currentSanity = maxSanity
        self.knowledge = detective.knowledge
        self.communication = detective.communication
        self.tention = detective.tention
        self.strenght = detective.strenght
        self.will = detective.will
        self.territory = Place(name: detective.initialPlace, type: .city, monsters: [])
    }
    
    var concetration = 0
    var resource = 0
    
}
