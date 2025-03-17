//
//  main.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 31.01.2025.
//

import Foundation

print("Game Started")

printHorribleGreeting()

print("")

var gameController = MainGameController()

var playerController = PlayerController()

var territories : [Place] = []

//Detectives from JSON to Detective structure
var componentController = ComponentController(myths: [""], monsters: [""])
componentController.downloadItems()

//Select Detective phase
while playerController.detective == nil {
    printTextWithDelay("Select your Detective")
    
    for i in 0..<componentController.detectives.count {
        print("\(i+1). \(componentController.detectives[i].name)")
    }
    
    print("")

    let number = Int(readLine() ?? "0") ?? 0

    if number > 0 && number <= componentController.detectives.count {
        playerController.updateWithDetective(detective: componentController.detectives[number-1])
    } else {
        print("Type correct number from the list")
    }
    
    print("")
}


print("You select \(playerController.detective?.name ?? "unknown")")

while gameController.roundCounter < 11 {
    
    //first action
    print("Select territory where you want to go?")
    
    //TODO: now its placeholder
    territories = gameController.createPlaces()
    
    while !gameController.playerSelectedTerritory {
        for i in 0..<territories.count {
            print("\n \(i+1). \(territories[i].name) - \(territories[i].type)")
            print(territories[i].portal ? "🔵 A strange portal shimmers in the air..." : "❌ No portals here.")
            print(!territories[i].monsters.isEmpty ? "👹 A terrifying monster lurks in the shadows!" : "🌿 The place is eerily quiet.")
        }
        
        print("")

        let number = Int(readLine() ?? "0") ?? 0
        
        if number > 0 && number <= territories.count {
            playerController.territory = territories[number - 1]
            gameController.playerSelectedTerritory = true
        } else {
            print("Type correct number from the list")
        }
        
        print("You go to \(playerController.territory?.name ?? "unknown")")
    }
    
    //second action
    gameController.selectAction(for: playerController)
    
    //third action
    if playerController.territory?.monsters.count ?? 0 > 0 {
        gameController.combat()
    } else {
        gameController.encounter()
    }
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
