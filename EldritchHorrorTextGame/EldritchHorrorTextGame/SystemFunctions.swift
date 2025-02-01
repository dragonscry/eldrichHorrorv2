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

func rollDice() {
    print("Rolling dice 🎲", terminator: "")
    for _ in 1...3 {
        print(".", terminator: "")
        fflush(stdout)
        usleep(500_000) // Delay for a short time to simulate rolling
    }
    print()
    
    // Final roll
    let finalRoll = Int.random(in: 1...6)
    print("You rolled a \(finalRoll)!", terminator: "")
    fflush(stdout)
}


