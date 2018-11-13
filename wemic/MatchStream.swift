//
//  MatchStream.swift
//  wemic
//
//  Created by Tyler Hong on 10/5/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import Kingfisher

class MatchStream: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    let dispatchGroup = DispatchGroup()
    var userGender = String()
    var userMatchPreference = String()
    var poolToDraw = String()
    var poolArray:[String] = [String]()  //array of all the people in the specified pool
    var randomNumberArray:[Int] = [Int]()
    var matchStreamArray = [String]()  //final 10 or less person array of ids
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserGender()
        getUserMatchPreference()
        dispatchGroup.notify(queue: .main) {  // if it doesnt receive a dispatch notification from getusersmatchpref,
            // this block of code will not run
            self.checkWhatPoolToDraw()    // sets up user pool to draw from
            self.createMatchStreamArray()
        }
    }
    
    func createMatchStreamArray() {
        Database.database().reference().child(poolToDraw).observeSingleEvent(of: .value) { (snapshot) in
            
            let dict = snapshot.value as! NSDictionary
            self.poolArray = dict.allKeys as! [String]   //gets all user ids that are the specific pool in the array
            self.getRandomizedNumbers()                 //gets x random numbers in an array where x = 10 unless theres not 10 ppl                   in pool
            for i in 0...self.randomNumberArray.count - 1 {
                let randomNumber = self.randomNumberArray[i]
                let randomID = self.poolArray[randomNumber]
                self.matchStreamArray.append(randomID)  //final people array is the actual people that will appear in MS
                
            }
            //
            for i in 0...self.matchStreamArray.count - 1 {
                Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).child("oldPotentialMatches").child(self.matchStreamArray[i]).setValue(self.matchStreamArray[i]) // under each user, we put all the people who that user has already seen
            }
        }
    }
    
    /* This function generates an array of random numbers. */
    func getRandomizedNumbers() {
        var numIterations = 10
        if poolArray.count < 10 {
            numIterations = poolArray.count - 1
        }
        for i in 0...numIterations {
            var randNumb = Int(arc4random_uniform(UInt32(poolArray.count)))
            while randomNumberArray.contains(randNumb){
                randNumb = Int(arc4random_uniform(UInt32(poolArray.count)))
            }
            randomNumberArray.append(randNumb)
        }
    }
    
    func checkWhatPoolToDraw(){
        
        if userGender == "Male" && userMatchPreference == "Female" {
            poolToDraw = "BiFemaleStraightFemale"
        }
        else if userGender == "Female" && userMatchPreference == "Male" {
            poolToDraw = "BiMaleStraightMale"
        }
        else if userGender == "Female" && userMatchPreference == "Both" {
            poolToDraw = "BiFemaleGayFemaleStraightMale"
        }
        else if userGender == "Male" && userMatchPreference == "Both" {
            poolToDraw = "BiMaleGayMaleStraightFemale"
        }
        else if userGender == "Male" && userMatchPreference == "Male" {
            poolToDraw = "BiMaleGayMale"
        }
        else if userGender == "Female" && userMatchPreference == "Female" {
            poolToDraw = "BiFemaleGayFemale"
        }
    }
    
    /* This function obtains the current user's gender. */
    func getUserGender() {
        dispatchGroup.enter()
    Database.database().reference().child("Users").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as! [String:AnyObject]
            self.userGender = value["Gender"] as! String
            self.dispatchGroup.leave()
        }
        
    }
    
    /* This function obtains what gender the user is attracted to. */
    func getUserMatchPreference() {
        dispatchGroup.enter()
        let currentUser = Auth.auth().currentUser!
        let dataRef = Database.database().reference()
        dataRef.child("Users").child(currentUser.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                self.userMatchPreference = dictionary["AttractedTo"] as! String
                self.dispatchGroup.leave()
                
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.matchStreamArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "msCell", for: indexPath) as! MatchStreamCell
        let selectedUserID = matchStreamArray[indexPath.row]
        
        
        Database.database().reference().child("Users").child(selectedUserID).observeSingleEvent(of: .value) { (snapshot) in
            if let personDict = snapshot.value as? [String:AnyObject] {  //obtain all information of user
                //ex. AttractedTo: men  Gender: Male  Hometown:Austin, TX
                let profileURLString = personDict["Profile Picture"] as! String
                let profileURL = URL(string: profileURLString)
                let fullName = personDict["User's full name"] as! String
                let year = personDict["User's Year"] as! String
                let tagline = personDict["Tagline"] as! String
                let hometown = personDict["Hometown"] as! String
                let major = personDict["Major"] as! String
                
                
                cell.Name.text = fullName  //update textfield on storyboard
                cell.Year.text = year
                cell.Major.text = major
                cell.Hometown.text = hometown
                cell.Tagline.text = tagline
                cell.ProfilePic.kf.setImage(with: profileURL)  //use the kingfisher cocoapod to set image from url
                
                
    
                
                
            }
            
            
        }
        
        return cell
    }
    
    
}
