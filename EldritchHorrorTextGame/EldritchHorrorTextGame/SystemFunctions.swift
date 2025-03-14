//
//  SystemFunctions.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 31.01.2025.
//

import Foundation

func printTextWithDelay(_ text: String, delay: TimeInterval = 0.5) {
    for char in text {
        print(char, terminator: "")
        fflush(stdout)
        usleep(50_000)
    }
    print() // Move to the next line after completion
}

func rollDice() -> Int {
    let finalRoll = Int.random(in: 1...6)
    return finalRoll
}

func rollManyDice(times: Int) -> [Int] {
    //TODO: need a func where amount of Dice is equal of times

    print("Rolling dice " + String(repeating: "🎲", count: times), terminator: "")
    for _ in 1...3 {
        print(".", terminator: "")
        fflush(stdout)
        usleep(500_000) // Delay for a short time to simulate rolling
    }
    print()
    var tempRolls: [Int] = []
    for _ in 1...times {
        tempRolls.append(rollDice())
    }
    
    return tempRolls

}
