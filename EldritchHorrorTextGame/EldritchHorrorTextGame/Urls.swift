//
//  Urls.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 19.02.2025.
//

import Foundation

struct Urls {
    static let detectiveRules = URL(fileURLWithPath: "/Users/denismerkotun/Desktop/projects/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/Resources/detective.json")
    static let itemsUrl = URL(fileURLWithPath: "/Users/denismerkotun/Desktop/projects/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/Resources/items.json")
    static let monstersUrl = URL(fileURLWithPath: "/Users/denismerkotun/Desktop/projects/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/Resources/monsters.json")
    static let encountersUrl = URL(fileURLWithPath: "/Users/denismerkotun/Desktop/projects/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/Resources/encounters.json")
    
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
