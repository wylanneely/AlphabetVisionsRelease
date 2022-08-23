//
//  WordGoalTableViewCell.swift
//  AlphabetVisionABCs
//
//  Created by Wylan L Neely on 8/23/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit

class WordGoalTableViewCell: UITableViewCell {
    
    
    var wordGoal: WordGoal?
    
    func setWordGoal(_ wordGoal: WordGoal) {
        self.wordGoal = wordGoal
        wordHintLabel.text = wordGoal.word
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var wordImageHint: UIImageView!
    @IBOutlet weak var wordHintLabel: UILabel!
    
    @IBAction func soundButtonTapped(_ sender: Any) {
        
    }
}
