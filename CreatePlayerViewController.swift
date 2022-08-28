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

        self.hideKeyboardWhenTappedAround()
        
        characterImage.isUserInteractionEnabled = true//do not forget to rightnot move


        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swiped(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        characterImage.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action:  #selector(self.swiped(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        characterImage.addGestureRecognizer(swipeLeft)
        // Do any additional setup after loading the view.
    }
    
     // MARK: - Outlets & Action

    @IBOutlet weak var playerAgeText: UITextField!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var nicknameText: UITextField!
    
    
    //MARK: - Image Gesture

    
    let imageList = CharacterImageList
    func getImage(named: String)->UIImage? {
        let image = UIImage(named: named)
        return image
    }
    
    var imageIndex: NSInteger = 0
    var maxImages = 11

    @objc func swiped(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizer.Direction.right :
                // decrease index first
                imageIndex = imageIndex - 1
                // check if index is in range
                if imageIndex < 0 {
                    imageIndex = maxImages
                }
                if let characterI = imageList[imageIndex] {
                    characterImage.image = characterI
                }
            case UISwipeGestureRecognizer.Direction.left:
                // increase index first
                imageIndex = imageIndex + 1
                // check if index is in range
                if imageIndex > maxImages {
                    imageIndex = 0
                }
                
                if let characterI = imageList[imageIndex] {
                    characterImage.image = characterI
                }
                
            default:
                break //stops the code/codes nothing.
                
            }
            
        }
    }
        
        
        
    
    
    //MARK: - Extract and Save PLayer
    func exctractPlaterData() -> (name:String,age:String,pic:String) {

        if let name = nicknameText.text, let age = playerAgeText.text {
            return (name,age,"lion")
        }
        return ("","","")
    }
    
     @IBAction func createPlayerTapped(_ sender: Any) {
   
         let playerData = exctractPlaterData()
         GameMaster.global.savePlayerData(name: playerData.name, age: playerData.age, ImageID: playerData.pic)
         
         
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
