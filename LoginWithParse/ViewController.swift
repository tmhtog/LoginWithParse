//
//  ViewController.swift
//  LoginWithParse
//
//  Created by Attapong on 10/15/2557 BE.
//  Copyright (c) 2557 Attapong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var usernameLogin: UITextField!

    @IBOutlet var passwordLogin: UITextField!
    
    @IBAction func loginAction(sender: AnyObject) {
        usernameLogin.text = usernameLogin.text
        passwordLogin.text = passwordLogin.text
        
        PFUser.logInWithUsernameInBackground(usernameLogin.text, password: passwordLogin.text){
            (user:PFUser!, error:NSError!)->Void in
            if user != nil{
                println("Login successfull")
                self.presentViewController(FirstViewTableViewController(), animated: true, completion: nil)
            }else{
                println("Login failed")
            }
            
            
        }
        

    }
    override func viewDidAppear(animated: Bool) {
        var loginAlert:UIAlertController = UIAlertController(title: "Please Sing up or Login", message: "Please Sign up or Login First ", preferredStyle: UIAlertControllerStyle.Alert)
        
        loginAlert .addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "your username"
        })
        loginAlert.addTextFieldWithConfigurationHandler({
            textfield in
            textfield.placeholder = "Your password"
            textfield.secureTextEntry = true
        })
        // addAction Cancel
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as [NSArray]
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
            }))
        
        // addAction Sign up
        loginAlert.addAction(UIAlertAction(title: "Sign up", style: UIAlertActionStyle.Default, handler: {
            alertAction in
            let textFields:NSArray = loginAlert.textFields as [NSArray]
            let usernameTextfield:UITextField = textFields.objectAtIndex(0) as UITextField
            let passwordTextfield:UITextField = textFields.objectAtIndex(1) as UITextField
            
            var user:PFUser = PFUser()
            user.username = usernameTextfield.text
            user.password = passwordTextfield.text
            
            user.signUpInBackgroundWithBlock{
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                println("Sign up Success")
            } else {
                let errorString = error.localizedDescription
                println(errorString)

            }
        }
        }))
        
        self.presentViewController(loginAlert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

