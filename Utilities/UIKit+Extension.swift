//
//  UIKit+Extension.swift
//  AlphabetVisionABCs
//
//  Created by Wylan L Neely on 8/28/22.
//  Copyright © 2022 Apple. All rights reserved.
//

import UIKit


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
