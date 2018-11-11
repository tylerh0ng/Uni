//
//  ViewController.swift
//  wemic
//
//  Created by Tyler Hong on 8/3/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField


class LoginScreen: UIViewController {
    
    
    @IBOutlet weak var letsGetStarted: UITextView!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordField: SkyFloatingLabelTextField!
    @IBOutlet weak var treeLogo: UIImageView!
    @IBOutlet weak var passwordDots: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var pineappleLogo: UIImageView!
    
    var didOnboarding = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpEmail()
        setUpPassword()
        
        // Code to set up a transparent navigation bar.
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    /* This function tells us whether the user has done at least one onboarding screen. */
    func userDidOnboarding() {
        Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (snapshot) in
                self.didOnboarding = snapshot.exists()
            
        }
    }
    
    /* Function to perform login actions once login has been pressed. */
    @IBAction func loginPressed(_ sender: UIButton) {
        if emailField.text == "" || passwordField.text == "" {   //if the user doesn't enter anything in email or password
            let alert = UIAlertController(title: "Missing Information", message: "Provide your Stanford Email and your password.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                print(cancel)
            }
            alert.addAction(ok)
            self.present(alert,animated:true,completion:nil)
            
        }
        else {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (Result, Error) in
                self.userDidOnboarding()
                if Error == nil {
                    if Auth.auth().currentUser?.isEmailVerified != true { //if you're not verified
                        let alert = UIAlertController(title: "Email Not Verified", message: "Please verify your email before logging in.", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .default, handler: {action in
                            try! Auth.auth().signOut()
                        })
                        alert.addAction(ok)
                        self.present(alert,animated:true,completion:nil)
                    }
                    else if self.didOnboarding {
                        self.performSegue(withIdentifier: "LoginScreenToMatchStream", sender: nil)
                    }
                    else {
                        self.performSegue(withIdentifier: "LoginScreenToNameCreation", sender: nil)
                    }
                }
                else{
                    let alert = UIAlertController(title: "Login Unsuccessful", message: "Please make sure your email and password are entered correctly.", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "Ok", style: .default) { (cancel) in
                        print(cancel)
                    }
                    alert.addAction(ok)
                    self.present(alert,animated:true,completion:nil)
                }
            }
        }
    }
    
    /* Function used to set up SkyFloatingLabelTextField for email. */
    func setUpEmail() {
        let textFieldFrame = CGRect(x: 93, y: 311, width: 264, height: 60)
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
    
    /* Function used to set up SkyFloatingLabelTextField for password. */
    func setUpPassword() {
        let textFieldFrame = CGRect(x: 93, y: 434, width: 264, height: 60)
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
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

