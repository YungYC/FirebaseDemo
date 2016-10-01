//
//  ThirdViewController.swift
//  FirebaseDemo
//
//  Created by Duncan on 2016/6/20.
//  Copyright © 2016年 Duncan. All rights reserved.
//

import UIKit
import Firebase
//import FBSDKCoreKit
import FBSDKLoginKit

class ThirdViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    

    @IBOutlet weak var accountInput: UITextField!
    @IBOutlet weak var pwInput: UITextField!
    
    
    @IBAction func signInButtonPressed(_ sender: AnyObject) {
        guard accountInput.text != "" else {
            YUNGalert("請輸入帳號")
            return
        }
        guard pwInput.text != "" else {
            showMessagePrompt("請輸入密碼")
            return
        }
            
        FIRAuth.auth()?.signIn(withEmail: accountInput.text!, password: pwInput.text!, completion: { (user, error) in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
            }
        })
    }
    
    @IBAction func signUpButtonPressed(_ sender: AnyObject) {
        guard accountInput.text != "" else {
            showMessagePrompt("請輸入要註冊的帳號")
            return
        }
        guard pwInput.text != "" else {
            showMessagePrompt("請輸入要註冊的密碼")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: accountInput.text!, password: pwInput.text!, completion: { (user, error) in
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
            }
        })
    }
    
    
    @IBAction func touchScreen(_ sender: AnyObject) {
        
        accountInput.resignFirstResponder()
        pwInput.resignFirstResponder()
    }

    @IBOutlet weak var FBSDKSignInButton: FBSDKLoginButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signInSilently()
        
        //let loginButton = FBSDKLoginButton()
        FBSDKSignInButton.delegate = self
    
        FIRAuth.auth()?.addStateDidChangeListener {auth, user in
        
            if let user = user{
            
                print(user)
                self.performSegue(withIdentifier: "logedIn", sender: user)
                
            }else{
            
                print("NO USER")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        try! FIRAuth.auth()!.signOut()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOut(_ sender: AnyObject) {

        //GIDSignIn.sharedInstance().signOut()
        try! FIRAuth.auth()!.signOut()
        //GIDSignIn.sharedInstance().disconnect()
        
        
        if let user = FIRAuth.auth()?.currentUser {
            print(user)
        }else{
            print("NO USER 2")
        }
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if let error = error {
            
            print(error.localizedDescription)
            return
        }
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential){ (user, error) in
            print("Sign In to Firebase with FBSDK")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("FBSDK LOG OUT")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as! LogedInViewController
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
