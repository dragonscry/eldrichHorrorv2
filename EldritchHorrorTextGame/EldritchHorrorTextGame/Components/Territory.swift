//
//  Territory.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 01.02.2025.
//

import Foundation


//type of territory
enum TerritoryType: CaseIterable {
    case city, forest, sea
    
}

//struct for Place
struct Place {
    
    let name: String
    let type: TerritoryType
    let monsters: [Monster]
    var portal = false
    
    
}
