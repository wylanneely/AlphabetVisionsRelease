//
//  LandingPageViewController.swift
//  AlphabetVisionABCs
//
//  Created by Wylan L Neely on 8/27/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let playerData = GameMaster.global.getPlayer1Data() {
            self.player = playerData
            continueButton.isEnabled = true
        }
        
    }


    var player: Player?

    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBAction func continueTapped(_ sender: Any) {
        
        if (GameMaster.global.getPlayer1Data() != nil){
          self.performSegue(withIdentifier: "toHomeVC", sender: self)
      }
        
    }
    
    @IBAction func newGameTapped(_ sender: Any) {
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeVC" {
            if let VC = segue.destination as? HomeViewController {
                VC.player = GameMaster.global.getPlayer1Data()
            }
        }
        
    }
}
