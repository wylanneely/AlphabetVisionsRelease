//
//  CreatePlayerViewController.swift
//  AlphabetVisionABCs
//
//  Created by Wylan L Neely on 8/25/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class CreatePlayerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     // MARK: - Outlets & Action

    @IBOutlet weak var playerAgeText: UITextField!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var nicknameText: UITextField!
    
//    func exctractPlaterData() -> (name:String,age:String,pic:UIImage?) {
//
//        if let name = nicknameText.text, let age = playerAgeText.text, let pic = characterImage.image {
//            return (name,age,pic)
//        }
//        return ("","",nil)
//    }
    
     @IBAction func createPlayerTapped(_ sender: Any) {
   
        // let playerData = exctractPlaterData()
         
         
         
     }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     */

}
