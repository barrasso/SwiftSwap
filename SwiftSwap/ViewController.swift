//
//  ViewController.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit
import Parse
import TwitterKit

class ViewController: UIViewController, UITextFieldDelegate {

    // Activity spinner indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    // MARK: Outlets
    
    @IBOutlet var usernameTextField: UITextField!
    
    // MARK: Actions
    
    @IBAction func didTapButton(sender: AnyObject)
    {
        // init error string
        var error = "";
        
        // check for empty username or password text fields
        if (usernameTextField.text == "")
        {
            error = "Please enter a valid .edu email"
        }
        
        // if the error string is not empty
        if (error != "")
        {
            self.displayAlert("Error", error: error)
        }
            
        else
        {
            // inital activity indicator setup
            activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0.0, 0.0, 50, 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true;
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            
            // add to view and start animation
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            
            // begin ignoring user interaction
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            // try to log user in
            PFUser.logInWithUsernameInBackground(usernameTextField.text, password:"mypass") {
                (user: PFUser!, error: NSError!) -> Void in
                if user != nil {
                    
                    // stop animation and end ignoring events
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    // successful login
                    println("logged in")
                    
                    // Create and initialize a DGTAppearance object
                    let digitsAppearance = DGTAppearance()
                    // Change color properties to customize the look
                    digitsAppearance.backgroundColor = self.UIColorFromHex(0x00264e, alpha: 1.0)
                    digitsAppearance.accentColor = self.UIColorFromHex(0x55acee, alpha: 1.0)
                    
                    // Start the authentication flow with the custom appearance. Nil parameters for default values.
                    let digits = Digits.sharedInstance()
                    digits.authenticateWithDigitsAppearance(digitsAppearance, viewController: nil, title: nil) { (session, error) in
                        // Inspect session/error objects
                        if error == nil {
                            // go to table segue
                            self.performSegueWithIdentifier("showMainFeed", sender: self)
                        } else {
                            NSLog("Error: %@", error)
                        }
                    }
                    
                } else {
                    
                    // try to sign the user up
                    var user = PFUser()
                    user.username = self.usernameTextField.text
                    user.password = "mypass"
                    
                    user.signUpInBackgroundWithBlock {
                        (succeeded: Bool!, error: NSError!) -> Void in
                        if error == nil {
                            
                            // stop animation and end ignoring events
                            self.activityIndicator.stopAnimating()
                            UIApplication.sharedApplication().endIgnoringInteractionEvents()
                            
                            // successful sign up
                            println("signed up")
                            
                            // Create and initialize a DGTAppearance object
                            let digitsAppearance = DGTAppearance()
                            // Change color properties to customize the look
                            digitsAppearance.backgroundColor = self.UIColorFromHex(0x00264e, alpha: 1.0)
                            digitsAppearance.accentColor = self.UIColorFromHex(0x55acee, alpha: 1.0)
                            
                            // Start the authentication flow with the custom appearance. Nil parameters for default values.
                            let digits = Digits.sharedInstance()
                            digits.authenticateWithDigitsAppearance(digitsAppearance, viewController: nil, title: nil) { (session, error) in
                                // Inspect session/error objects
                                if error == nil {
                                
                                // go to table segue
                                self.performSegueWithIdentifier("showMainFeed", sender: self)
                                } else {
                                    NSLog("Error: %@", error)
                                }
                            }
                            
                        } else {
                            // The login/signup failed
                            NSLog("Error: %@", error)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: View Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColorFromHex(0x00264e, alpha: 1.0)
        
        self.usernameTextField.delegate = self;
        
        // LOGGING OUT EVERYTIME FOR DEMONSTRATIVE PURPOSES ////////////
        Digits.sharedInstance().logOut()
        
        // check if current user is logged in
        if PFUser.currentUser() != nil
        {
            // who is current user
            NSLog("Current User: %@", PFUser.currentUser().username)
            
            // segue to user table if already logged in
            
        }
        
        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Other Functions
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool
    {
        self.view.endEditing(true);
        return false;
    }
    
    // MARK: Alert Functions
    
    func displayAlert(title:String, error:String)
    {
        // display error alert
        var errortAlert = UIAlertController(title: title, message: error, preferredStyle: UIAlertControllerStyle.Alert)
        errortAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { action in
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(errortAlert, animated: true, completion: nil)
    }

}

