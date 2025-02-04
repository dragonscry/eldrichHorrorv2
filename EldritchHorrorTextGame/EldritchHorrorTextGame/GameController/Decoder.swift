//
//  Decoder.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 04.02.2025.
//

import Foundation

func loadJSON<T: Codable>(from fileName: String, bundle: Bundle = .main) -> T? {
    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
        print("❌ Error: File \(fileName).json not found.")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("❌ Error decoding \(fileName).json: \(error)")
        return nil
    }
}
