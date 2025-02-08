//
//  main.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 31.01.2025.
//

import Foundation

print("Start")

printHorribleGreeting()

var gameController = MainGameController()

print("Select your Detective")
let detectives = ["Idann", "Kai", "Lars"]
for i in 0..<detectives.count {
    print("\(i+1). \(detectives[i])")
}

let number = Int(readLine() ?? "0") ?? 0

if number > 0 && number <= detectives.count {
    gameController.detective = detectives[number - 1]
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
