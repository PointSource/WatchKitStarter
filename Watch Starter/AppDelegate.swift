//
//  AppDelegate.swift
//  Watch Starter
//
//  Created by Erin Bartholomew on 7/7/15.
//  Copyright (c) 2015 Erin Bartholomew. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
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

    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        // Fix to handle background network requests --> http://www.fiveminutewatchkit.com/blog/2015/3/11/one-weird-trick-to-fix-openparentapplicationreply
        // --------------------
        var tempTask:UIBackgroundTaskIdentifier?
        tempTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            reply(nil)
            UIApplication.sharedApplication().endBackgroundTask(tempTask!)
        })
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC * 2)), dispatch_get_main_queue()) { () -> Void in
            UIApplication.sharedApplication().endBackgroundTask(tempTask!)
        }
        // --------------------
        
        var infoTask:UIBackgroundTaskIdentifier?
        infoTask = UIApplication.sharedApplication().beginBackgroundTaskWithExpirationHandler({ () -> Void in
            reply(nil)
            UIApplication.sharedApplication().endBackgroundTask(infoTask!)
        })
        
        //Only the following types are supported in the response object:
        //String
        //Number
        //NSData
        //NSDate
        //Array
        //Dictionary
        
        if let action = userInfo?["action"] as? String {
            switch action {
            case "action1":
                reply(["response":"Action 1 Processed"])
            case "action2":
                reply(["response":"Action 2 Processed"])
            default:
                reply(["response":"Invalid Request"])
            }
        } else {
            reply(["response":"Invalid Request"])
        }
        
        UIApplication.sharedApplication().endBackgroundTask(infoTask!)
    }

}

