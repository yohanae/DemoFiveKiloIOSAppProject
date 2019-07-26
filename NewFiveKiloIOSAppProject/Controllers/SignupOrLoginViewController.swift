//
//  SignupOrLoginViewController.swift
//  NewFiveKiloIOSAppProject
//
//  Created by yoyo on 7/16/19.
//  Copyright © 2019 Compitence Over Identity Technologies. All rights reserved.
//

import UIKit

class SignupOrLoginViewController: UIViewController {

   let programaticSegue = ProgramaticSegueways()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToSignupPageButton(_ sender: Any) {
        programaticSegue.segueTo(currentViewController: self, destinationViewController: "signupVC")
    }
    
    
    @IBAction func goToLoginPageButton(_ sender: Any) {
        programaticSegue.segueTo(currentViewController: self, destinationViewController: "loginVC")
    }
    
    

}
