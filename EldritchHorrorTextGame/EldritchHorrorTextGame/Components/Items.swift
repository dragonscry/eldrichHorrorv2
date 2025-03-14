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
    let actionKey: String?
    var action: Action? = nil  // Will be assigned after decoding
}
