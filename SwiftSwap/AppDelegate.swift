//
//  AppDelegate.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit
import Parse
import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Initialize Parse
        Parse.setApplicationId("9j4Sf88XiKWH3EPgNyApttIe26tHtUULsjXcJtwp",
            clientKey: "76MWdlpMqbhQdD5imPp6cgi2cRIZi9I1BjJsOCi8")
        
        // Initialize Fabric
        Twitter.sharedInstance().startWithConsumerKey("kLpF7FPOTkQ2m8pbtoFp3LNZG",
            consumerSecret: "CaU420CntPebTaICzOqZdUQhz1qSOH7ekCgqn3RhMZQRe5vGVQ")
        Fabric.with([Twitter.sharedInstance()])
        
        // hide status bar
        application.setStatusBarHidden(true, withAnimation: UIStatusBarAnimation(rawValue: 1)!)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

