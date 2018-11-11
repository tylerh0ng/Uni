//
//  SexualOrientation.swift
//  wemic
//
//  Created by Tyler Hong on 8/18/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import AIFlatSwitch
import Firebase


class SexualOrientation: UIViewController {
    
    @IBOutlet weak var maleSwitch: AIFlatSwitch!
    @IBOutlet weak var femaleSwitch: AIFlatSwitch!
    

    
    @IBAction func maleChecked(_ sender: AIFlatSwitch) {
        if maleSwitch.isSelected {
            femaleSwitch.isEnabled = false
        }
        else {
            femaleSwitch.isEnabled = true
        }
    }
    
    @IBAction func femaleChecked(_ sender: AIFlatSwitch) {
        if femaleSwitch.isSelected {
            maleSwitch.isEnabled = false
        }
        else {
            maleSwitch.isEnabled = true
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let databaseRef = Database.database().reference()
        
        if maleSwitch.isSelected {
            databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("Gender").setValue("Male")
            performSegue(withIdentifier: "SexualOrientationToPreferredSex", sender: self)
        }
        else if femaleSwitch.isSelected {
            databaseRef.child("Users").child(Auth.auth().currentUser!.uid).child("Gender").setValue("Female")
            performSegue(withIdentifier: "SexualOrientationToPreferredSex", sender: self)
        }
        else {
            let alert = UIAlertController(title: "No Options Selected", message: "Please select an option for your gender.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
        }
        
    }
    
}
