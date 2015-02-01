//
//  PostImageViewController.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit
import Parse

class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: Variables
    
    // flags
    var photoSelected:Bool = false
    
    // Activity spinner indicator
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    // MARK: Outlets
    
    @IBOutlet var imageToPost: UIImageView!
    
    @IBOutlet var captionTextField: UITextField!
    
    // MARK: Actions
    
    @IBAction func newPicture(sender: AnyObject)
    {
        // init picker controller
        var image = UIImagePickerController()
        
        // set delegate
        image.delegate = self
        
        // access photo library
        image.sourceType = UIImagePickerControllerSourceType.Camera
        
        // allows user to edit picture
        image.allowsEditing = false
        
        // present the picker controller
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func usePicture(sender: AnyObject)
    {
        // init picker controller
        var image = UIImagePickerController()
        
        // set delegate
        image.delegate = self
        
        // access photo library
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // allows user to edit picture
        image.allowsEditing = false
        
        // present the picker controller
        self.presentViewController(image, animated: true, completion: nil)
    }
    
    @IBAction func createPost(sender: AnyObject)
    {
        // define error
        var error = ""
        
        // check text fields
        if (self.captionTextField.text == "") {
            error = "Please enter a caption."
        }
        
        // check if user has chosen an image
        if (photoSelected == false) {
            error = "Please choose an image."
        }
        
        // check for error
        if (error != "") {
            displayAlert("Error With Post", error: error)
        } else {
            
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
            
            // define new parse object
            var post = PFObject(className: "Posts")
            post["caption"] = self.captionTextField.text
            post["username"] = PFUser.currentUser().username
            
            // save post with image if success
            post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                
                if success == false {
                    // stop animation and end ignoring events
                    self.activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    self.displayAlert("Could Not Create Post", error: "Please try again later.")
                } else {
                    
                    // set image data
                    let imageFile = PFFile(name: "image.jpg", data: UIImageJPEGRepresentation(self.imageToPost.image, 0.1))
                    
                    // add to post
                    post["imageFile"] = imageFile
                    
                    // save post with image if success
                    post.saveInBackgroundWithBlock{(success: Bool!, error: NSError!) -> Void in
                        
                        // stop animation and end ignoring events
                        self.activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        if success == false {
                            self.displayAlert("Could Not Create Post", error: "Please try again later.")
                        } else {
                            
                            // go back to feed
                            self.performSegueWithIdentifier("showMainFeed", sender: self)
                            
                            self.displayAlert("Success", error: "Your post has been created successfully!")
                            
                            // reset flag, caption and image
                            self.photoSelected = false
                            self.imageToPost.image = UIImage(named: "fabric.png")
                            self.captionTextField.text = ""
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Image Picker Delegate Functions
    
    // user did finishing picking an image
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        NSLog("Picked Image")
        
        // close image picker
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // set chosen image to UIImage on view
        imageToPost.image = image
        
        // set photo selected flag to true
        photoSelected = true
    }
    
    // MARK: View Functions
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColorFromHex(0xf0f0f0, alpha: 1.0)
        
        // set text field delegates
        self.captionTextField.delegate = self
        
        // reset flag, caption and image
        photoSelected = false
        imageToPost.image = UIImage(named: "fabric.png")
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
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent)
    {
        // end editing when touching view
        self.view.endEditing(true)
    }
    
    // MARK: Text Field Delegate Functions
    
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
            
        }))
        
        self.presentViewController(errortAlert, animated: true, completion: nil)
    }
}
