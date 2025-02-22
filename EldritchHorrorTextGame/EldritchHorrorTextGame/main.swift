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

var playerController : PlayerController?

//Detectives from JSON to Detective structure
var componentController = ComponentController(myths: [""], monsters: [""], bosses: [""], items: [""], spells: [""], artifacts: [""])

while gameController.selectedDetective == false {
    print("Select your Detective")
    
    for i in 0..<componentController.detectives.count {
        print("\(i+1). \(componentController.detectives[i].name)")
    }
    
    print("")

    let number = Int(readLine() ?? "0") ?? 0

    if number > 0 && number <= componentController.detectives.count {
        playerController = PlayerController(detective: componentController.detectives[number-1])
        gameController.selectedDetective = true
    } else {
        print("Type correct number from the list")
    }
    
    print("")
}

//TODO: need fix initialization of player controller
print("You select \(playerController?.detective.name ?? "unknown")")

while gameController.roundCounter < 11 {
    
    //first action
    print("Select territory where you want to go?")
    
    //second action
    print("Select action")
    
    //third action
    print("Encounter!")
    
    //myth action
    print("MYTH")
    
}

print("Time to fight with BOSS!!!")



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
