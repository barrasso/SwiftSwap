//
//  MainTableViewController.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit
import Parse

class MainTableViewController: UITableViewController {
    
    // feed arrays
    var captions = [String]()
    var usernames = [String]()
    var images = [UIImage]()
    var imageFiles = [PFFile]()
    
    // refresh control
    var refresher: UIRefreshControl!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColorFromHex(0xf0f0f0, alpha: 1.0)
        self.tableView.allowsSelection = false
        
        // set nav bar items
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: Selector("showSettings"))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("showNewPost"))
        
        // define refresher
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "")
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresher)
        
        // update all posts
        updatePosts()
    }
    
    func updatePosts()
    {
        println(PFUser.currentUser().username)
        
        // query for all posted objects from other users
        var query = PFQuery(className: "Posts")
        query.orderByDescending("createdAt")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                
                println("successfully retrieved objects: \(objects.count)")
                
                // clean up arrays
                self.captions.removeAll(keepCapacity: true)
                self.usernames.removeAll(keepCapacity: true)
                self.images.removeAll(keepCapacity: true)
                self.imageFiles.removeAll(keepCapacity: true)
                
                for object in objects {
                    
                    // get captions and usernames and add to arrays
                    self.captions.append(object["caption"] as String)
                    self.usernames.append(object["username"] as String)
                    self.imageFiles.append(object["imageFile"] as PFFile)
                    
                    // get photo post time
                    
                    // reload table data
                    self.tableView.reloadData()
                }
                
            } else {
                println("Error: \(error)")
            }
            
            // stop refreshing
            self.refresher.endRefreshing()
        }
    }
    
    func refresh()
    {
        updatePosts()
        NSLog("Resfreshed table.")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // Return the number of rows in the section.
        return self.captions.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 550
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("mainCell", forIndexPath: indexPath) as MainCellTableViewCell

        // set cell labels
        cell.postedByUser.text = usernames[indexPath.row]
        cell.postCaption.text = captions[indexPath.row]
        
        // query for image data
        imageFiles[indexPath.row].getDataInBackgroundWithBlock {
            (imageData: NSData!, error: NSError!) -> Void in
            if error == nil {
                
                // create image from data
                let image = UIImage(data: imageData)
                cell.postedImage.image = image
                
            } else {
                println("Error: \(error)")
            }
        }

        return cell
    }
    
    // MARK: Other Functions
    
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
    
    func showNewPost()
    {
        self.performSegueWithIdentifier("showNewPost", sender: self)
    }
    
    func showSettings()
    {
        self.performSegueWithIdentifier("showSettings", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
