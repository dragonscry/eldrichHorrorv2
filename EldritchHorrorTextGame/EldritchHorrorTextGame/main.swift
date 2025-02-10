//
//  main.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 31.01.2025.
//

import Foundation

print("Start")

printHorribleGreeting()

print("")

var gameController = MainGameController()

//Detectives from JSON to Detective structure
let detectives = ["Idann", "Kai", "Lars"]

while gameController.detective == nil {
    print("Select your Detective")
    
    for i in 0..<detectives.count {
        print("\(i+1). \(detectives[i])")
    }
    
    print("")

    let number = Int(readLine() ?? "0") ?? 0

    if number > 0 && number <= detectives.count {
        gameController.detective = detectives[number - 1]
    } else {
        print("Type correct number from the list")
    }
    
    print("")
}

print("You select \(gameController.detective ?? "unknown")")


//greetings

//init players

//init cards:
//encounter cards
//items cards
//artifacts cards
//init myths


//select boss

//10 raund systems

//gameplay:
//1st phase: players move and actions
//2nd phase: encounters: player interact with territory
//3d phase: myth phase

//final - boss fight
