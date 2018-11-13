//
//  AdditionalPictures.swift
//  wemic
//
//  Created by Tyler Hong on 9/15/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CropViewController


class AdditionalPictures: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    @IBOutlet weak var pic4: UIImageView!
    var currPic = UIImageView()   //variable to keep track of what picture the user selected
    
    @IBAction func pic1Pressed(_ sender: Any) {
        currPic = pic1
        pictureTapped()
    }
    
    @IBAction func pic2Pressed(_ sender: Any) {
        currPic = pic2
        pictureTapped()
    }
    @IBAction func pic3Pressed(_ sender: Any) {
        currPic = pic3
        pictureTapped()
    }
    @IBAction func pic4Pressed(_ sender: Any) {
        currPic = pic4
        pictureTapped()
    }
    
    
    /* When the user taps a palm tree image. */
    func pictureTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    /* Delegate function executed after the user finished picking a photo. The CropViewController is automatically brought up after a selection. */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator.
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            let cropViewController = CropViewController(croppingStyle: .circular, image: pickedImage)
            cropViewController.delegate = self
            present(cropViewController, animated: true, completion: nil)
        }
    }
    
    /* Delegate function executed after the user is done cropping the image. */
    func cropViewController(_ cropViewController: CropViewController, didCropToCircularImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        currPic.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func nextButtonPressed(_ sender: Any) {
        uploadPic1()
        uploadPic2()
        uploadPic3()
        uploadPic4()
    }
    
    func uploadPic1() {
        let currUser = Auth.auth().currentUser!.uid
        let selectedImageData = pic1.image!.jpegData(compressionQuality: 1)
        let storageRef = Storage.storage().reference()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.child("Users").child(currUser).child("Picture1").putData(selectedImageData!, metadata: metadata) { (metadata, error) in
            if error != nil{
                print("There was a problem uploading")
                return
            }
            
            storageRef.child("Users").child(currUser).child("Picture1").downloadURL(completion: { (url, error) in
                let databaseRef = Database.database().reference()
                databaseRef.child("Users").child(currUser).child("Picture1").setValue(url?.absoluteString)
            })
            
        }
    }
    func uploadPic2() {
        let currUser = Auth.auth().currentUser!.uid
        let selectedImageData = pic2.image!.jpegData(compressionQuality: 1)
        let storageRef = Storage.storage().reference()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.child("Users").child(currUser).child("Picture2").putData(selectedImageData!, metadata: metadata) { (metadata, error) in
            if error != nil{
                print("There was a problem uploading")
                return
            }
            
            storageRef.child("Users").child(currUser).child("Picture2").downloadURL(completion: { (url, error) in
                let databaseRef = Database.database().reference()
                databaseRef.child("Users").child(currUser).child("Picture2").setValue(url?.absoluteString)
            })
            
        }
    }
    func uploadPic3() {
        let currUser = Auth.auth().currentUser!.uid
        let selectedImageData = pic3.image!.jpegData(compressionQuality: 1)
        let storageRef = Storage.storage().reference()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.child("Users").child(currUser).child("Picture3").putData(selectedImageData!, metadata: metadata) { (metadata, error) in
            if error != nil{
                print("There was a problem uploading")
                return
            }
            
            storageRef.child("Users").child(currUser).child("Picture3").downloadURL(completion: { (url, error) in
                let databaseRef = Database.database().reference()
                databaseRef.child("Users").child(currUser).child("Picture3").setValue(url?.absoluteString)
            })
            
        }
    }
    func uploadPic4() {
        let currUser = Auth.auth().currentUser!.uid
        let selectedImageData = pic4.image!.jpegData(compressionQuality: 1)
        let storageRef = Storage.storage().reference()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.child("Users").child(currUser).child("Picture4").putData(selectedImageData!, metadata: metadata) { (metadata, error) in
            if error != nil{
                print("There was a problem uploading")
                return
            }
            
            storageRef.child("Users").child(currUser).child("Picture4").downloadURL(completion: { (url, error) in
                let databaseRef = Database.database().reference()
                databaseRef.child("Users").child(currUser).child("Picture4").setValue(url?.absoluteString)
            })
            
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
