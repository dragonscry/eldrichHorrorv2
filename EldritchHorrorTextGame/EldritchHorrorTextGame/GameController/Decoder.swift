//
//  Decoder.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 04.02.2025.
//

import Foundation

func loadJSON<T: Codable>(from fileName: String, bundle: Bundle = .main) -> T? {
    //need check if bundle is for console app:
//    guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
//        print("❌ Error: File \(fileName).json not found.")
//        return nil
//    }
    
    //return rule for file
    let url = Urls.returnUrl(for: fileName)
    
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        print("❌ Error decoding \(fileName).json: \(error)")
        return nil
    }
}

//TODO: needs to fix bug
extension Bundle {
    func decode<T: Decodable>(from fileName: String) -> T? {
        
        
        //UNCOMMENT WHEN WILL BE GOOD
//        if let path = Bundle.main.path(forResource: "detective", ofType: "json") {
//            print("✅ File found at: \(path)")
//        } else {
//            print("❌ File not found in bundle.")
//        }
        
        let fileUrL = Urls.returnUrl(for: fileName)

        do {
            let data = try Data(contentsOf: fileUrL)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            print("❌ Error decoding \(fileName): \(error)")
            return nil
        }
    }
}
