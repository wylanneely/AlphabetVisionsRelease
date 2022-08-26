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
    
    var writtenWords: [String]? = nil
    var completedWordGoals:[WordGoal] = []
    
    //TODO: -Extract written word transcript & check if wordGoals wwere met
    
    func exctractCorrectWords(from transcript: String) {
        for word in getCurrentWordGoals() {
            writtenWords?.append(word.word)
            if transcript == word.word {
                writtenWords
            }
            
        }
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
    
    //MARK: - UserDefaults Save & Load
    
    //TODO: - add support for 3 save charachters
    let kPlayer1Name = "kP1Name"
    let kPlayer1Age = "kP1Age"
    let kP1Progress = "kP1Progress"
   // let kPlayer1ImageID = "kP1Name"
    
    func savePlayerData(name: String, age: String, ImageID: Int) {
        UserDefaults.standard.set(name, forKey: kPlayer1Name)
        UserDefaults.standard.set(age, forKey: kPlayer1Age)
    }
    
    func getPlayer1Data()-> Player? {
        let age = UserDefaults.standard.integer(forKey: kPlayer1Age)
        if  let name = UserDefaults.standard.string(forKey: kPlayer1Name) {
          return Player(nickName: name, age: age, animal: nil)
      } else {
          return nil
      }
    }
    
}
