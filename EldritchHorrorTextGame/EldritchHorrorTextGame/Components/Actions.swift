//
//  Actions.swift
//  EldritchHorrorTextGame
//
//  Created by Denys on 05.02.2025.
//
class ActionManager {
    static let shared = ActionManager()
    
    //TODO: needs to provide action for unique actions or item action
    private let actionMap: [String: Action] = [
        "heal": RestAction(),
        "increaseStrength": IncreaseStrength(),
        "decreaseStrength": DecreaseStrength(),
        
        "increaseKnowledge": IncreaseKnowledge(),
        "decreaseKnowledge": DecreaseKnowledge(),
        
        "increaseCommunication": IncreaseCommunication(),
        "decreaseCommunication": DecreaseCommunication(),
        
        "increaseTension": IncreaseTension(),
        "decreaseTension": DecreaseTension(),
        
        "increaseWill": IncreaseWill(),
        "decreaseWill": DecreaseWill()
    ]
    
    func getAction(for key: String?) -> Action? {
        guard let key = key else { return nil }
        return actionMap[key]
    }
    
    let detectiveActions:[Action] = [
        RestAction(),
        PrepareResource(),
        PrepareConcetration()
    ]
}

protocol Action {
    var name: String { get }
    var description: String { get }
    var typeAction: GamePhase { get }
    
    func execute(for player: PlayerController)
}




