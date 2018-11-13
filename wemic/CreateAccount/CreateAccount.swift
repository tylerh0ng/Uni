//
//  CreateAccount.swift
//  wemic
//
//  Created by Tyler Hong on 8/8/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SkyFloatingLabelTextField
import FirebaseAuth

class CreateAccount: UIViewController {
    
    
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        setUpEmail()
        setUpPassword()
        setUpConfirmPassword()
    }
    
    
    /* This function describes what happens when the next button is pressed, and includes a bunch of edge cases to test. */
    @IBAction func nextPressed(_ sender: UIButton) {
        
        //////////////////* FIX BUG HERE */////////////////////
        let attemptedEmail = emailField.text!
        let index = attemptedEmail.index(of: "@")
        let emailDomain = attemptedEmail.suffix(from: index!)
        
        if emailField.text == "" || passwordField.text == "" || confirmPasswordField.text == "" {
            let alert = UIAlertController(title: "Missing Information", message: "Please make sure that you filled out all the fields above.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
        }
        else if passwordField.text != confirmPasswordField.text! {
            let alert = UIAlertController(title: "Passwords Do Not Match", message: "Please make sure that you typed the same password in both password fields.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
        }
        else if passwordField.text!.count < 6 {
            let alert = UIAlertController(title: "Password Is Too Short", message: "Please make sure that your password is at least 6 characters long.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
        }
        else if emailDomain != "@stanford.edu" {
            let alert = UIAlertController(title: "Not a Stanford Email", message: "Please be sure you sign up using your Stanford email.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
            
        }
        else {
            Auth.auth().createUser(withEmail: attemptedEmail, password: passwordField.text!) { (User, Error) in
                if Error != nil {
                    let alert = UIAlertController(title: "Sign Up Failed", message: "Please try again.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                        print(cancel)
                    }
                    alert.addAction(ok)
                    self.present(alert,animated:true,completion:nil)
                }
                else {
                    Auth.auth().signIn(withEmail: attemptedEmail, password: self.passwordField.text!, completion: { (User, Error) in
                        if Error == nil{
                            print("success")
                        }
                    } )
                    Auth.auth().currentUser!.sendEmailVerification(completion: { (Error) in
                        if Error == nil{
                            let alert = UIAlertController(title: "Email Verification Sent", message: "Once you have verified your email, you will be able to login to Uni.", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "Ok", style: .default, handler: { action in                                self.navigationController?.popViewController(animated: true)
                            })
                            alert.addAction(ok)
                            self.present(alert,animated:true,completion:nil)
                            
                        }
                    } )
                    try! Auth.auth().signOut()  //sign out user once verification email has been sent
                }
            }
        }
    }
    
    func setUpEmail() {
        let textFieldFrame = CGRect(x: 47, y: 285, width: 292, height: 60)
        emailField.placeholder = "Stanford Email"
        emailField.frame = textFieldFrame
        emailField.title = "Stanford Email"
        emailField.textColor = UIColor.white
        emailField.lineColor = UIColor.white
        emailField.lineHeight = 1
        emailField.selectedLineHeight = 1
        emailField.selectedTitleColor = UIColor.white
        emailField.selectedLineColor = UIColor.white
        emailField.placeholderFont = UIFont(name: "Avenir", size: 18)
        emailField.tintColor = UIColor.white
        emailField.placeholderColor = UIColor.white
    }
    
    func setUpPassword() {
        let textFieldFrame = CGRect(x: 47, y: 382, width: 292, height: 60)
        passwordField.placeholder = "Password"
        passwordField.title = "Password"
        passwordField.frame = textFieldFrame
        passwordField.textColor = UIColor.white
        passwordField.lineColor = UIColor.white
        passwordField.selectedTitleColor = UIColor.white
        passwordField.selectedLineColor = UIColor.white
        passwordField.placeholderFont = UIFont(name: "Avenir", size: 18)
        passwordField.tintColor = UIColor.white
        passwordField.lineHeight = 1
        passwordField.selectedLineHeight = 1
        passwordField.placeholderColor = UIColor.white
    }
    
    func setUpConfirmPassword() {
        let textFieldFrame = CGRect(x: 47, y: 482, width: 292, height: 60)
        confirmPasswordField.placeholder = "Confirm Password"
        confirmPasswordField.title = "Confirm Password"
        confirmPasswordField.frame = textFieldFrame
        confirmPasswordField.textColor = UIColor.white
        confirmPasswordField.lineColor = UIColor.white
        confirmPasswordField.selectedTitleColor = UIColor.white
        confirmPasswordField.selectedLineColor = UIColor.white
        confirmPasswordField.placeholderFont = UIFont(name: "Avenir", size: 18)
        confirmPasswordField.tintColor = UIColor.white
        confirmPasswordField.lineHeight = 1
        confirmPasswordField.selectedLineHeight = 1
        confirmPasswordField.placeholderColor = UIColor.white
    }
}
