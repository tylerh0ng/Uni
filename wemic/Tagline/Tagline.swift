//
//  Tagline.swift
//  wemic
//
//  Created by Tyler Hong on 10/17/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
import Firebase

class Tagline: UIViewController {
    
    @IBOutlet weak var taglineTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        setUpTextField()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if (taglineTextField.text?.count)! < 30 {
            let currentUser = Auth.auth().currentUser!
            let myDatabase = Database.database().reference()
        myDatabase.child("Users").child(currentUser.uid).child("Tagline").setValue(taglineTextField.text)
            self.performSegue(withIdentifier: "TaglineToHomeMajor", sender: nil)
        }
        else {
            let alert = UIAlertController(title: "Character limit exceeded", message: "Please make sure that your tagline is less than 30 characters.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
        }
        
    }
    
    
    
    func setUpTextField() {
        let textFieldFrame = CGRect(x: 106, y: 416, width: 309, height: 60)
        taglineTextField.placeholder = "Tagline"
        taglineTextField.frame = textFieldFrame
        taglineTextField.title = "Tagline (ex. I can handle the business side)"
        taglineTextField.textColor = UIColor.white
        taglineTextField.lineColor = UIColor.white
        taglineTextField.lineHeight = 1
        taglineTextField.selectedLineHeight = 1
        taglineTextField.selectedTitleColor = UIColor.white
        taglineTextField.selectedLineColor = UIColor.white
        taglineTextField.placeholderFont = UIFont(name: "Avenir", size: 18)
        taglineTextField.tintColor = UIColor.white
        taglineTextField.placeholderColor = UIColor.white
    }
}
