//
//  HomeViewController.swift
//  AlphabetVisionABCs
//
//  Created by Wylan L Neely on 8/28/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if name == "" {
            setLabels()
        } else {
            nicknameLabel.text = "Hello, \(name)"
        }
        // Do any additional setup after loading the view.
    }
    
    func setLabels(){
        if let nickname = player?.nickName {
            nicknameLabel.text = "Welcome Back, \(nickname)"
        }
    }
    var player: Player?
    var name: String = ""
    
    @IBOutlet weak var nicknameLabel: UILabel!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
