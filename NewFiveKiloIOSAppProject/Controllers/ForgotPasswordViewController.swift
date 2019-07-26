//
//  ForgotPasswordViewController.swift
//  NewFiveKiloIOSAppProject
//
//  Created by yoyo on 7/16/19.
//  Copyright © 2019 Compitence Over Identity Technologies. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var emailAddressOutlet: UITextField!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

  
    @IBAction func sendEmailButton(_ sender: Any) {
        guard let email = emailAddressOutlet.text else { return }
        
        Auth.auth().sendPasswordReset(withEmail: email)  { (error) in
            if error != nil {
                //this is where we will add our error alert
                return
            } else if error == nil {
                //this is where we will add our success alert
            }
        }
    }
    

    
    @IBAction func backButton(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    

}
