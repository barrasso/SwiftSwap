//
//  PostImageViewController.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    
    // flags
    var photoSelected:Bool = false
    
    // Activity spinner indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    // MARK: Outlets
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var priceTextField: UITextField!
    @IBOutlet var captionTextField: UITextField!
    
    // MARK: Actions
    
    @IBAction func newPicture(sender: AnyObject)
    {
        println("new picture")
    }
    
    @IBAction func usePicture(sender: AnyObject)
    {
        println("use picture")
    }
    
    @IBAction func createPost(sender: AnyObject)
    {
        println("create post")
    }
    
    // MARK: View Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // set text field delegates
        self.titleTextField.delegate = self
        self.priceTextField.delegate = self
        self.captionTextField.delegate = self
        
        // reset flag, caption and image
        photoSelected = false
        imageToPost.image = UIImage(named: "fabric.png")
        self.titleTextField.text = ""
        self.priceTextField.text = ""
        self.captionTextField.text = ""
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
