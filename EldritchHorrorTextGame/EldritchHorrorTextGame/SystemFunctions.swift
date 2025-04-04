//
//  SystemFunctions.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 31.01.2025.
//

import Foundation
import Darwin

func printTextWithDelay(_ text: String, delay: TimeInterval = 0.5) {
    // Disable terminal input echo
    var term = termios()
    tcgetattr(STDIN_FILENO, &term)
    term.c_lflag &= ~UInt(ECHO | ICANON)
    tcsetattr(STDIN_FILENO, TCSANOW, &term)
    
    // Print text with delay
    for char in text {
        print(char, terminator: "")
        fflush(stdout)
        usleep(10_000)
    }
    print() // Move to the next line after completion
    
    // Enable terminal input echo again
    term.c_lflag |= UInt(ECHO | ICANON)
    tcsetattr(STDIN_FILENO, TCSANOW, &term)
}

func rollDice() -> Int {
    let finalRoll = Int.random(in: 1...6)
    return finalRoll
}

func rollManyDice(times: Int) -> [Int] {
    
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
    print("RESULTS: \(tempRolls)")
    return tempRolls
}

func getSuccessfullResultsCount(from rolls: [Int], playerSuccessfullResults results: [Int]) -> Int {
    
    var tempResult = 0
    
    for roll in rolls {
        if results.contains(roll) {
            tempResult += 1
        }
    }
    return tempResult
}

func checkStats(stat: String, for player: PlayerController, gamePhase: GamePhase, difficulty: Int = 0) -> (Bool, Int) {
    
    //checking how many stat for rolls
    let statRolls = max(1, player.totalStatValue(for: stat, player: player, gamePhase: gamePhase) - difficulty)
    //rolls so dices
    player.currentResults = rollManyDice(times: statRolls)
    
    useConcetration(player: player)
    
    while !player.getItemsWithActions(gamePhase: gamePhase).isEmpty {
        print("Do you want to use item? (y/n)")
        let input = readLine()?.lowercased()
        if input == "n" {
            break
        } else if input == "y" {
            selectItemAction(for: player, gamePhase: gamePhase)
        } else {
            print("Invalid input! Try Again!")
        }
    }
    
    let successfullResults = getSuccessfullResultsCount(from: player.currentResults, playerSuccessfullResults: player.successfullResults)
    
    if successfullResults > 0 {
        return (true, successfullResults)
    } else {
        return (false, 0)
    }
}

func selectItemAction(for player: PlayerController, gamePhase: GamePhase) {
    
    let items = player.getItemsWithActions(gamePhase: gamePhase)
    
    // Display items with actions
    print("\nSelect an item to use:")
    for (index, item) in items.enumerated() {
        print("\(index + 1). \(item.name) - \(item.action?.description ?? "No action")")
    }
    
    // Read user input
    print("\nEnter the number of the item to use:")
    if let input = readLine(), let choice = Int(input),
       choice > 0, choice <= items.count {
        
        let selectedItem = items[choice - 1]
        
        if let itemIndex = player.items.firstIndex(where: { $0.name == selectedItem.name }) {
            
            // Execute item action
            player.items[itemIndex].action?.execute(for: player)
            
            // Handle single-use items
            if player.items[itemIndex].isSingleUse {
                player.items.remove(at: itemIndex)
                print("\(selectedItem.name) has been used and removed from your inventory.")
            } else {
                player.allItemsForGame[itemIndex].usedThisRound = true
                print("\(selectedItem.name) has been used this round.")
            }
        }
        
    } else {
        print("Invalid choice. Try again.")
        selectItemAction(for: player, gamePhase: gamePhase)
    }
}


func useConcetration(player: PlayerController) {
    while player.concetration > 0 {
        print("You have \(player.concetration) concentration left. Use concentration to add 1 roll? (y/n)")
        let input = readLine()?.lowercased()
        if  input == "y" {
            player.currentResults += rollManyDice(times: 1)
            player.concetration -= 1
            print("You tried to add successfull result. Total results: \(player.currentResults)")
        } else if input == "n" {
            break
        } else {
            print("Invalid input, please try again.\n")
        }
    }
}

func selectAction(for player: PlayerController, gamePhase: GamePhase) {
    var availableActions = player.getAvailableActions().filter { action in
        action.typeAction == gamePhase
    }
    
    if player.territory?.type == .city {
        availableActions.append(BuyItemAction())
    }
    
    let aviableItems = player.getItemsWithActions(gamePhase: gamePhase)
    
    if !aviableItems.isEmpty {
        availableActions.append(UseItem())
    }
    
    while player.actionPerRound > 0 {
        print("You can make \(player.actionPerRound) action(s)!")
        
        
        print("\nChoose an action:")
        for (index, action) in availableActions.enumerated() {
            print("\(index + 1). \(action.name)")
        }
        
        print("\nEnter the number of your action:")
        
        if let input = readLine(), let choice = Int(input),
           choice > 0, choice <= availableActions.count {
            let selectedAction = availableActions[choice - 1]
            if selectedAction.name == "Use Item" {
                selectedAction.execute(for: player)
                selectItemAction(for: player, gamePhase: gamePhase)
                availableActions.remove(at: choice - 1)
            } else {
                selectedAction.execute(for: player)
                availableActions.remove(at: choice - 1)
            }
            
        } else {
            print("Invalid choice. Try again.")
            continue
        }
    }
    
}

func endOfRound(player: PlayerController, gameController: MainGameController) {
    player.actionPerRound = 2
    player.countOfSuccessfullResults = 0
    player.territory = nil
    player.currentResults = []
    gameController.playerSelectedTerritory = false
}


//checking how many stats
//checking results
//u have concetration - do you want to use it?
//u have items - do you want to use it?
//checking success or not and how many success
