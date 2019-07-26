//
//  SignupViewController.swift
//  NewFiveKiloIOSAppProject
//
//  Created by yoyo on 7/16/19.
//  Copyright © 2019 Compitence Over Identity Technologies. All rights reserved.
//

import UIKit
import Firebase



class SignupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let programaticSegue = ProgramaticSegueways()
    let alert = Alerts()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector (handleTheSelectedProfileImageView)))
    }
    
   
    @objc func handleTheSelectedProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromThePicker: UIImage?
        
        if let editedProfileImage = info [.editedImage] as? UIImage {
            selectedImageFromThePicker = editedProfileImage
             self.profileImageView.image = selectedImageFromThePicker!
             dismiss(animated: true, completion: nil)
            
        } else if let orignalProfileImage = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromThePicker = orignalProfileImage
            self.profileImageView.image = selectedImageFromThePicker!
            dismiss(animated: true, completion: nil)
        }
    
    }
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func signupButton(_ sender: Any) {
        signupRegister()
    }
    
    
    
    func signupRegister() {
        guard let username = usernameTextfield.text else{ return }
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password, completion : { (result, error) in
            if error != nil {
                print ("error is here 1")
                self.alert.showAlert(Title: "blablabla", Message: "blablabla", viewControllerToPresentAlert: self)
                return
            }
            guard let uid = result?.user.uid else {
                return
            }
            
            //At this point our user has succesfully been authenticated
            
            let profileImageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("profileImages").child("\(profileImageName).png")
            if let uploadData = self.profileImageView.image!.pngData() {
                storageRef.putData(uploadData, metadata: nil, completion:
                    { (metadata, error) in
                        if error != nil {
                            print("error putting data to storage")
                            return
                        }
                        
                        storageRef.downloadURL(completion: { (url, error) in
                            if error != nil {
                                print(error!.localizedDescription)
                                return
                            }
                            if let profileImageUrl = url?.absoluteString {
                                let values = ["name": username, "email": email, "profileImageUrl": profileImageUrl] as [String : Any]
                                self.registerUserIntoDatabaseWithUid(uid: uid, values: values as [String : AnyObject])
                            }
                        })
                    })
                }
            })
        }
    
    
    
    private func registerUserIntoDatabaseWithUid( uid: String, values: [String:AnyObject]) {
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        
        
        let ref = Database.database().reference(fromURL: "https://demofor5kiloproject.firebaseio.com/" )
        let userReference = ref.child("user").child(uid)
        userReference.updateChildValues( values, withCompletionBlock: {
            (err, ref) in
            if err != nil {
                
                //this is where we'll write our error alert
                return
            }
            
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil{
                    //this is where we'll write our error alert
                    return
                }
                
                self.goToHomePage()
                
            })
        })
    }
    
    
    
    func goToHomePage() {
         programaticSegue.segueTo(currentViewController: self, destinationViewController: "tabBarVC")
    }

    
    @IBAction func backButton(_ sender: Any) {
         programaticSegue.segueTo(currentViewController: self, destinationViewController: "signupOrLoginVC")
    }
    
    
}
