//
//  ClassYear.swift
//  wemic
//
//  Created by Tyler Hong on 8/17/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AIFlatSwitch

class ClassYear: UIViewController {
    
    @IBOutlet weak var freshmanButton: AIFlatSwitch!
    @IBOutlet weak var sophomoreButton: AIFlatSwitch!
    @IBOutlet weak var juniorButton: AIFlatSwitch!
    @IBOutlet weak var seniorButton: AIFlatSwitch!
    
    
    @IBAction func froshChecked(_ sender: AIFlatSwitch) {
        if freshmanButton.isSelected {   //when a user clicks frosh, if they are checking it then disable all other buttons
            sophomoreButton.isEnabled = false
            juniorButton.isEnabled = false
            seniorButton.isEnabled = false
        }
        else {  //if a user is unchecking frosh, then enable all the other buttons again
            sophomoreButton.isEnabled = true
            juniorButton.isEnabled = true
            seniorButton.isEnabled = true
        }
    }
    
    @IBAction func sophomoreChecked(_ sender: AIFlatSwitch) {
        if sophomoreButton.isSelected {
            freshmanButton.isEnabled = false
            juniorButton.isEnabled = false
            seniorButton.isEnabled = false
        }
        else {
            freshmanButton.isEnabled = true
            juniorButton.isEnabled = true
            seniorButton.isEnabled = true
        }
    }
    
    @IBAction func juniorChecked(_ sender: AIFlatSwitch) {
        if juniorButton.isSelected {
            freshmanButton.isEnabled = false
            sophomoreButton.isEnabled = false
            seniorButton.isEnabled = false
        }
        else {
            freshmanButton.isEnabled = true
            sophomoreButton.isEnabled = true
            seniorButton.isEnabled = true
        }
    }
    
    @IBAction func seniorChecked(_ sender: AIFlatSwitch) {
        if seniorButton.isSelected {
            freshmanButton.isEnabled = false
            sophomoreButton.isEnabled = false
            juniorButton.isEnabled = false
        }
        else {
            freshmanButton.isEnabled = true
            sophomoreButton.isEnabled = true
            juniorButton.isEnabled = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let databaseRef = Database.database().reference()
        
        if freshmanButton.isSelected {
            databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("User's Year").setValue("Frosh")
            self.performSegue(withIdentifier: "ClassYearToSexualOrientation", sender: self)
        }
        else if sophomoreButton.isSelected {
            databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("User's Year").setValue("Sophomore")
            self.performSegue(withIdentifier: "ClassYearToSexualOrientation", sender: self)
        }
        else if juniorButton.isSelected {
            databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("User's Year").setValue("Junior")
            self.performSegue(withIdentifier: "ClassYearToSexualOrientation", sender: self)
        }
        else if seniorButton.isSelected {
            databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("User's Year").setValue("Senior")
            self.performSegue(withIdentifier: "ClassYearToSexualOrientation", sender: self)
        }
        else {  // case where user doesn't select a button
            let alert = UIAlertController(title: "No Options Selected", message: "Please select an option for your class year.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
        }
        
    }
    
    
    
}
