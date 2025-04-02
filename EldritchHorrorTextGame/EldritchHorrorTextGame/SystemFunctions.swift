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

func checkStats(howManyRollsForStat: Int, for player: PlayerController) -> (Bool, Int) {
    var results = rollManyDice(times: howManyRollsForStat)
    
    while player.concetration > 0 {
            print("You have \(player.concetration) concentration left. Use concentration to add 1 roll? (y/n)")
            let input = readLine()?.lowercased()
            if  input == "y" {
                results += rollManyDice(times: 1)
                player.concetration -= 1
                print("You tried to add successfull results. Total results: \(results)")
            } else if input == "n" {
                break
            } else {
                print("Invalid input, please try again.\n")
            }
        }
    player.currentResults = results
    let successfullResults = getSuccessfullResultsCount(from: results, playerSuccessfullResults: player.successfullResults)
    
    if successfullResults > 0 {
        return (true, successfullResults)
    } else {
        return (false, 0)
    }
}

func endOfRound(player: PlayerController, gameController: MainGameController) {
    player.actionPerRound = 2
    player.countOfSuccessfullResults = 0
    player.territory = nil
    player.currentResults = []
    gameController.playerSelectedTerritory = false
}
