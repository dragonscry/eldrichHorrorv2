//
//  Urls.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 19.02.2025.
//

import Foundation

struct Urls {
    static let detectiveRules = URL(fileURLWithPath: "/Users/denys/Desktop/games/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/detective.json")
    static let itemsUrl = URL(fileURLWithPath: "/Users/denys/Desktop/games/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/items.json")
    static let monstersUrl = URL(fileURLWithPath: "/Users/denys/Desktop/games/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/monsters.json")
    static let encountersUrl = URL(fileURLWithPath: "/Users/denys/Desktop/games/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/encounters.json")
    
    static func returnUrl(for fileName: String) -> URL {
        switch fileName {
        case "detective":
            return detectiveRules
        case "items":
            return itemsUrl
        case "monsters":
            return monstersUrl
        case "encounters":
            return encountersUrl
        default:
            return URL(filePath: "/")
        }
    }
}
