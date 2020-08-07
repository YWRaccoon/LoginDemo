//
//  MainVC.swift
//  LoginDemo
//
//  Created by Yuni on 2019/8/17.
//  Copyright © 2019 Yuni. All rights reserved.
//

import UIKit
import GoogleSignIn

class MainVC: UIViewController {
    @IBOutlet weak var usernameTxtField: UITextField!
    @IBOutlet weak var pwdTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        if getIsLoginWithGoogle() {
            GIDSignIn.sharedInstance().signInSilently()
        }
    }
    
    @IBAction func googleSignInBtnPressed(_ sender: Any) {
        print("googleSignInBtnPressed")
    }
    
    fileprivate func showErrorPopup() {
        let alert = UIAlertController(title: "YW ERROR", message: "You can not sign in YW with Google.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    fileprivate func goSucceedPage(profile: GIDProfileData) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SucceedVC") as! SucceedVC
        vc.gProfile = profile
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func getIsLoginWithGoogle() -> Bool {
        return UserDefaults.standard.bool(forKey: "IsLoginWithGoogle")
    }
    
    fileprivate func setUserDefaultForLogin() {
        UserDefaults.standard.set(true, forKey: "IsLoginWithGoogle")
        UserDefaults.standard.synchronize()
    }
}

extension MainVC: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            print(error ?? "error")
            showErrorPopup()
            return
        }
        
        usernameTxtField.text = user.profile.email!
        setUserDefaultForLogin()
        goSucceedPage(profile: user.profile)
    }
}
