//
//  ProfilePicture.swift
//  wemic
//
//  Created by Tyler Hong on 8/20/18.
//  Copyright © 2018 wemic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import CropViewController


class ProfilePicture: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    @IBOutlet weak var profilePic: UIImageView!
    
    
    /* When the user taps the profile picture image. */
    @IBAction func profilePictureTapped(_ sender: Any) {
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
        profilePic.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    


    @IBAction func nextButtonPressed(_ sender: Any) {
        let currUser = Auth.auth().currentUser!.uid
        let selectedImageData = profilePic.image!.jpegData(compressionQuality: 1)
        let storageRef = Storage.storage().reference()
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.child("Users").child(currUser).child("Profile Picture").putData(selectedImageData!, metadata: metadata) { (metadata, error) in
            if error != nil{
                print("There was a problem uploading")
                return
            }

            storageRef.child("Users").child(currUser).child("Profile Picture").downloadURL(completion: { (url, error) in
                let databaseRef = Database.database().reference()
                databaseRef.child("Users").child(currUser).child("Profile Picture").setValue(url?.absoluteString)
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
