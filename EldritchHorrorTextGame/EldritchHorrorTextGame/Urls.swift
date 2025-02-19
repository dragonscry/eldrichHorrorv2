//
//  Urls.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 19.02.2025.
//

import Foundation

struct Urls {
    static let detectiveRules = URL(fileURLWithPath: "/Users/denys/Desktop/games/eldrichHorrorv2/EldritchHorrorTextGame/EldritchHorrorTextGame/detective.json")
    
    static func returnUrl(for fileName: String) -> URL {
        switch fileName {
        case "detective":
            return detectiveRules
        default:
            return URL(filePath: "/")
        }
    }
}
