//
//  ViewController.swift
//  CodeUp
//
//  Created by Aviral Aggarwal on 21/06/17.
//  Copyright © 2017 Aviral Aggarwal. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController,GIDSignInUIDelegate,GIDSignInDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance().signIn()
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        print("Credential is " , credential)
        dump(credential)
        
        // ...
        FIRAuth.auth()?.signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                return
            }
            // User is signed in
            // ...
            print(user?.uid)
            
            
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
}


