//
//  HomeMajor.swift
//  wemic
//
//  Created by Tyler Hong on 9/15/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SkyFloatingLabelTextField


class HomeMajor: UIViewController {
    
    @IBOutlet weak var hometownField: SkyFloatingLabelTextField!
    @IBOutlet weak var majorField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        setUpHometown()
        setUpMajor()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let currentUser = Auth.auth().currentUser!
        let myDatabase = Database.database().reference()
        myDatabase.child("Users").child(currentUser.uid).child("Hometown").setValue(hometownField.text)
        myDatabase.child("Users").child(currentUser.uid).child("Major").setValue(majorField.text)
        
    }
    
    
    func setUpHometown() {
        let textFieldFrame = CGRect(x: 53, y: 314, width: 309, height: 60)
        hometownField.placeholder = "Hometown (ex. Palo Alto, CA)"
        hometownField.frame = textFieldFrame
        hometownField.title = "Hometown (ex. Palo Alto, CA)"
        hometownField.textColor = UIColor.white
        hometownField.lineColor = UIColor.white
        hometownField.lineHeight = 1
        hometownField.selectedLineHeight = 1
        hometownField.selectedTitleColor = UIColor.white
        hometownField.selectedLineColor = UIColor.white
        hometownField.placeholderFont = UIFont(name: "Avenir", size: 18)
        hometownField.tintColor = UIColor.white
        hometownField.placeholderColor = UIColor.white
    }
    
    func setUpMajor() {
        let textFieldFrame = CGRect(x: 53, y: 461, width: 309, height: 60)
        majorField.placeholder = "Major (ex. Computer Science)"
        majorField.title = "Major (ex. Computer Science)"
        majorField.frame = textFieldFrame
        majorField.textColor = UIColor.white
        majorField.lineColor = UIColor.white
        majorField.selectedTitleColor = UIColor.white
        majorField.selectedLineColor = UIColor.white
        majorField.placeholderFont = UIFont(name: "Avenir", size: 18)
        majorField.tintColor = UIColor.white
        majorField.lineHeight = 1
        majorField.selectedLineHeight = 1
        majorField.placeholderColor = UIColor.white
    }
}
