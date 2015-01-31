//
//  SettingsViewController.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    // MARK: Actions
    
    @IBAction func logoutUser(sender: AnyObject)
    {
        PFUser.logOut()
        
        // segue to login
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    
    // MARK: View Functions

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}
