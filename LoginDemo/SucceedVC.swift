//
//  SucceedVC.swift
//  LoginDemo
//
//  Created by Yuni on 2019/8/17.
//  Copyright © 2019 Yuni. All rights reserved.
//

import UIKit
import GoogleSignIn

class SucceedVC: UIViewController {
    @IBOutlet weak var mainLabel: UILabel!
    
    var gProfile: GIDProfileData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if gProfile != nil {
            let exist = gProfile!.hasImage ? "exists" : "did not exist"
            let text = "Login YW with Google Succeed!\n"
                + "Your username is \(gProfile!.email!)\n"
                + "Your name is \(gProfile!.name!)\n"
                + "Your givenName is \(gProfile!.givenName!)\n"
                + "Your familyName is \(gProfile!.familyName!)\n"
                + "Your image \(exist).\n"
            mainLabel.text = text
        }
    }
    

    @IBAction func signOutBtnPressed(_ sender: Any) {
        if gProfile != nil {
            GIDSignIn.sharedInstance().signOut()
            setUserDefaultForLogin()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    fileprivate func setUserDefaultForLogin() {
        UserDefaults.standard.set(false, forKey: "IsLoginWithGoogle")
        UserDefaults.standard.synchronize()
    }
}
