//
//  NameCreation.swift
//  wemic
//
//  Created by Tyler Hong on 8/15/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import SkyFloatingLabelTextField

class NameCreation: UIViewController {
    
    
    @IBOutlet weak var firstName: SkyFloatingLabelTextField!
    @IBOutlet weak var lastName: SkyFloatingLabelTextField!
    
    
    /* Two functions to hide the navigation bar for this view controller. */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Show the Navigation Bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        // Hide the Navigation Bar
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    
    override func viewDidLoad() {
        setUpFirstName()
        setUpLastName()
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let currentUser = Auth.auth().currentUser!
        let myDatabase = Database.database().reference()
        myDatabase.child("Users").child(currentUser.uid).child("User's full name").setValue(firstName.text! + " " + lastName.text!)
    }
    
    func setUpFirstName() {
        let textFieldFrame = CGRect(x: 53, y: 314, width: 309, height: 60)
        firstName.placeholder = "First Name"
        firstName.frame = textFieldFrame
        firstName.title = "First Name"
        firstName.textColor = UIColor.white
        firstName.lineColor = UIColor.white
        firstName.lineHeight = 1
        firstName.selectedLineHeight = 1
        firstName.selectedTitleColor = UIColor.white
        firstName.selectedLineColor = UIColor.white
        firstName.placeholderFont = UIFont(name: "Avenir", size: 18)
        firstName.tintColor = UIColor.white
        firstName.placeholderColor = UIColor.white
    }
    
    func setUpLastName() {
        let textFieldFrame = CGRect(x: 53, y: 461, width: 309, height: 60)
        lastName.placeholder = "Last Name"
        lastName.title = "Last Name"
        lastName.frame = textFieldFrame
        lastName.textColor = UIColor.white
        lastName.lineColor = UIColor.white
        lastName.selectedTitleColor = UIColor.white
        lastName.selectedLineColor = UIColor.white
        lastName.placeholderFont = UIFont(name: "Avenir", size: 18)
        lastName.tintColor = UIColor.white
        lastName.lineHeight = 1
        lastName.selectedLineHeight = 1
        lastName.placeholderColor = UIColor.white
    }
    
}
