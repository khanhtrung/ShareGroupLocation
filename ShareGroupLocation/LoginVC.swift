//
//  LoginVC.swift
//  ShareGroupLocation
//
//  Created by Tran Khanh Trung on 11/10/16.
//  Copyright © 2016 TRUNG. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Facebook sign in button
        addFBLoginButton()
        
        // Add Custom Facebook sign in button
        addCustomFBLoginButton()
        
        // Add Google sign in button
        addGGLoginButton()
        
        // Add Custom Google sign in button
        addCustomGGLoginButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // Add Facebook sign in button
    fileprivate func addFBLoginButton() {
        let fbLoginButton = FBSDKLoginButton()
        fbLoginButton.frame = CGRect(x: 16, y: 50, width: view.frame.width-32, height: 50)
        view.addSubview(fbLoginButton)
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["email", "public_profile"]
    }
    
    // Add Custom Facebook sign in button
    func addCustomFBLoginButton() {
        let customFBLoginButton = UIButton(type: .system)
        customFBLoginButton.frame = CGRect(x: 16, y: 116, width: view.frame.width-32, height: 50)
        customFBLoginButton.backgroundColor = UIColor.blue
        customFBLoginButton.setTitleColor(UIColor.white, for: .normal)
        customFBLoginButton.setTitle("Custom Facebook Log in", for: .normal)
        customFBLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(customFBLoginButton)
        customFBLoginButton.addTarget(self, action: #selector(handleCustomFBLogginButton), for: .touchUpInside)
    }
    
    func handleCustomFBLogginButton() {
        FBSDKLoginManager().logIn(withReadPermissions:  ["email", "public_profile"], from: self)
        { (result: FBSDKLoginManagerLoginResult?, err: Error?) in
            if err != nil {
                print("Custom Facebook log in failed: \(err?.localizedDescription)")
                return
            }
            if let tokenString = result?.token?.tokenString {
                print("Custom Facebook Logged IN")
                print("\(tokenString)")
                self.getFBUserData()
                return
            }
            print("Custom Facebook Log in cancelled")
        }
    }
    
    // Add Google sign in button
    fileprivate func addGGLoginButton() {
        let ggLoginButton = GIDSignInButton()
        ggLoginButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width-32, height: 50)
        view.addSubview(ggLoginButton)
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Setup
        ggLoginButton.style = .wide
        ggLoginButton.colorScheme = .light
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    // Add Custom Google sign in button
    func addCustomGGLoginButton() {
        let customGGLoginButton = UIButton(type: .system)
        customGGLoginButton.frame = CGRect(x: 16, y: 116 + 66 + 66, width: view.frame.width-32, height: 50)
        customGGLoginButton.backgroundColor = UIColor.orange
        customGGLoginButton.setTitleColor(UIColor.white, for: .normal)
        customGGLoginButton.setTitle("Custom Google Log in", for: .normal)
        customGGLoginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(customGGLoginButton)
        customGGLoginButton.addTarget(self, action: #selector(handleCustomGGLogginButton), for: .touchUpInside)
    }
    
    func handleCustomGGLogginButton() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    func getFBUserData(){
        if let fbAccessToken = FBSDKAccessToken.current() {
            
            guard let tokenString = fbAccessToken.tokenString else { return }
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: tokenString)
            FIRAuth.auth()?.signIn(with: credential, completion: { ( user: FIRUser?, error:Error?) in
                if error != nil{
                    print("Error logging in with Facebook user aacount: \(error)")
                    return
                }
                
                guard let uid = user?.uid else { return }
                print("Firebase Logged IN with FB account: \(uid)")
            })
            
            FBSDKGraphRequest(
                graphPath: "/me",
                parameters: ["fields" : "id, name, email, first_name, last_name, picture.type(large)"]).start(completionHandler: { (connection, result, error) in
                    if error != nil {
                        print("Failed to start graph request: \(error)")
                        return
                    }
                    print(result)
                })
        }
    }
}

extension LoginVC: FBSDKLoginButtonDelegate {
    
    // Sent to the delegate when the button was used to login.
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription)
            return
        }
        print("Logged IN")
        getFBUserData()
    }
    
    // Sent to the delegate when the button was used to logout.
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged OUT")
    }
}

extension LoginVC: GIDSignInUIDelegate {
    
}
