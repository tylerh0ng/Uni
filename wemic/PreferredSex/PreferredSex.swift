//
//  PreferredSex.swift
//  wemic
//
//  Created by Tyler Hong on 8/18/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import AIFlatSwitch

class PreferredSex: UIViewController {
    
    @IBOutlet weak var guysSwitch: AIFlatSwitch!
    @IBOutlet weak var girlsSwitch: AIFlatSwitch!
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let databaseRef = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        /* The following lines of code are used to obtain the gender of the current user. */
        databaseRef.child("Users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:String]
            let userGender = value["Gender"]!
            
            
            /* The following lines of code are used to record what the user is attracted to. */
            
            if self.guysSwitch.isSelected && !self.girlsSwitch.isSelected {  //if you're attracted to only guys
                databaseRef.child("Users").child(userID!).child("AttractedTo").setValue("Male")
                if userGender == "Female" {   //place straight females into respective pools
                    databaseRef.child("BiFemaleStraightFemale").child(userID!).setValue(userID)
                    databaseRef.child("BiMaleGayMaleStraightFemale").child(userID!).setValue(userID)
                }
                else if userGender == "Male" { // place gay males into respective pools
                    databaseRef.child("BiMaleGayMaleStraightFemale").child(userID!).setValue(userID)
                    databaseRef.child("BiMaleGayMale").child(userID!).setValue(userID)
                }
                self.performSegue(withIdentifier: "PreferredSexToProfilePicture", sender: self)
            }
                
            else if !self.guysSwitch.isSelected && self.girlsSwitch.isSelected { //if you're attracted to only girls
                databaseRef.child("Users").child(userID!).child("AttractedTo").setValue("Female")
                if userGender == "Female" { //place gay females into respective pools
                    databaseRef.child("BiFemaleGayFemaleStraightMale").child(userID!).setValue(userID)
                    databaseRef.child("BiFemaleGayFemale").child(userID!).setValue(userID)
                }
                else if userGender == "Male" { //place striaght males into respective pools
                    databaseRef.child("BiMaleStraightMale").child(userID!).setValue(userID)
                    databaseRef.child("BiFemaleGayFemaleStraightMale").child(userID!).setValue(userID)
                }
                self.performSegue(withIdentifier: "PreferredSexToProfilePicture", sender: self)
            }
                
            else if self.guysSwitch.isSelected && self.girlsSwitch.isSelected { //if you're attracted to both
                databaseRef.child("Users").child(userID!).child("AttractedTo").setValue("Both")
                if userGender == "Female" { //place bi females into respective pools
                    databaseRef.child("BiFemaleGayFemale").child(userID!).setValue(userID)
                    databaseRef.child("BiFemaleStraightFemale").child(userID!).setValue(userID)
                    databaseRef.child("BiFemaleGayFemaleStraightMale").child(userID!).setValue(userID)
                }
                else if userGender == "Male" { //place bi males into respective pools
                    databaseRef.child("BiMaleStraightMale").child(userID!).setValue(userID)
                    databaseRef.child("BiMaleGayMaleStraightFemale").child(userID!).setValue(userID)
                    databaseRef.child("BiMaleGayMale").child(userID!).setValue(userID)
                }
                self.performSegue(withIdentifier: "PreferredSexToProfilePicture", sender: self)
            }
            else  { //if no option is selected
                let alert = UIAlertController(title: "No Options Selected", message: "Please select at least one option.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                    print(cancel)
                }
                alert.addAction(ok)
                self.present(alert,animated:true,completion:nil)
            }
        }
        
        
        
        
    }
    
}
