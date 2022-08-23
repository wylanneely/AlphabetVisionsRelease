//
//  GameController.swift
//  ARKitInteraction
//
//  Created by Wylan L Neely on 8/22/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import Foundation
import UIKit


class GameMaster: WordTranscriptDelegate {
    
    
    func exctractCorrectWords(from transcript: String) {
        
    }
    
    
    static let global = GameMaster()
    
    var player: Player?
    
    let defaults = UserDefaults.standard
    
    func loadPlayer()-> Player? {
        
        return nil
    }
    
    let goalsController = WordGoalController()
    
    func getCurrentWordGoals()->[WordGoal] {
       return goalsController.currentWordGoals
    }
    
    func setWordGoals(wordGoals:[WordGoal]) {
        self.goalsController.setWord(wordGoals: wordGoals)
    }
    
    
}
