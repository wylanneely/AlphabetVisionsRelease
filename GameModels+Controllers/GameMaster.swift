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
    
    var wordGoalStrings: [String] {
        var strings: [String] = []
        let currentGoals = getCurrentWordGoals()
        
        for g in currentGoals {
            strings.append(g.word.lowercased())
        }
        return strings
    }
    
    static let global = GameMaster()
    let virtualObject = VirtualObject()
    
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
