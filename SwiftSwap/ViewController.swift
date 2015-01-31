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

class ViewController: UIViewController {

    // MARK: Outlets
    
    
    // MARK: Actions
    
    
    @IBAction func didTapButton(sender: AnyObject)
    {
        // Create and initialize a DGTAppearance object with standard colors:
        let digitsAppearance = DGTAppearance()
        // Change color properties to customize the look:
        digitsAppearance.backgroundColor = UIColor.blackColor()
        digitsAppearance.accentColor = UIColor.greenColor()
        
        // Start the authentication flow with the custom appearance. Nil parameters for default values.
        let digits = Digits.sharedInstance()
        digits.authenticateWithDigitsAppearance(digitsAppearance, viewController: nil, title: nil) { (session, error) in
            // Inspect session/error objects
        }
    }
    
    // MARK: View Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

