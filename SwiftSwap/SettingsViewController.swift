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
        self.view.backgroundColor = UIColorFromHex(0xf0f0f0, alpha: 1.0)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Other Functions
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
