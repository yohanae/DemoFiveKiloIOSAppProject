//
//  PostViewController.swift
//  NewFiveKiloIOSAppProject
//
//  Created by yoyo on 7/26/19.
//  Copyright © 2019 Compitence Over Identity Technologies. All rights reserved.
//

import UIKit
import Firebase

class PostViewController: UIViewController {

    var alert = Alerts()
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var userPostTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
   
    @IBAction func postButton(_ sender: Any) {
        if usernameTextfield.hasText == true && userPostTextfield.hasText == true {
        savePostToFirebaseDatabase()
        } else if usernameTextfield.hasText == false || userPostTextfield.hasText == false {
            alert.showAlert(Title: "oops", Message: "You left a textfield empty!", viewControllerToPresentAlert: self)
        }
    }
    
    func savePostToFirebaseDatabase() {
        guard let username = usernameTextfield.text else{ return }
        guard let userPost = userPostTextfield.text else{ return }
        
    
        
//        guard let postID = Auth.auth().currentUser?. else {
//            return
//        }
        
        let postID = NSUUID().uuidString
        let values = ["name": username, "post": userPost] as [String : Any]
        self.registerUsersPostIntoDatabase(postID: postID, values: values as [String : AnyObject])
        
        usernameTextfield.text = ""
        userPostTextfield.text = ""
        
    }
    
    private func registerUsersPostIntoDatabase(postID: String, values: [String:AnyObject] ) {
        let ref = Database.database().reference(fromURL: "https://demofor5kiloproject.firebaseio.com/" )
        let userPostRef = ref.child("post").child(postID)
        userPostRef.updateChildValues( values, withCompletionBlock: {
            (err, ref) in
            if err != nil {
                
                //this is where we'll write our error alert
                return
            }
        })
    }
   

}
