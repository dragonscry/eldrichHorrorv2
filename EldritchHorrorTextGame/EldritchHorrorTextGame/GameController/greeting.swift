//
//  greeting.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 31.01.2025.
//
let greetings = [
    "Welcome, lost soul... Your fate is sealed.",
    "Ah, you dare enter? Prepare for your doom.",
    "You have entered the cursed realm... Welcome... or should I say, goodbye.",
    "Another victim walks through the gates... How delightful.",
    "The darkness awaits. Do you fear it?",
    "You think you can escape? You cannot.",
    "Your path is set, and there is no return.",
    "Welcome to your nightmare. It's just begun.",
    "Welcome, mortal. We are waiting for you.",
    "The shadows whisper your name... Prepare yourself."
]

func printHorribleGreeting() {
    
    //TODO: make this as static fields
    let green = "\u{001B}[0;32m"
        let bold = "\u{001B}[1m"
        let underline = "\u{001B}[4m"
        let reset = "\u{001B}[0m"
    
    let randomIndex = Int.random(in: 0..<greetings.count)
    print("\(green)\(bold)\(underline)"+greetings[randomIndex]+"\(reset)")
}


