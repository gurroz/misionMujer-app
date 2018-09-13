//
//  AppDelegate.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            print("Setting category to AVAudioSessionCategoryPlayback failed.")
        }
        
        // Changes TabBar colors
        UITabBar.appearance().tintColor = UIColor(red: 237/255.0, green: 78/255.0, blue: 78/255.0, alpha: 1)
        UITabBar.appearance().unselectedItemTintColor = UIColor(red: 46/255.0, green: 196/255.0, blue: 182/255.0, alpha: 1)
        
        
        /* Get references to all of our controllers so we can set the intial data */
        let tabBarController = self.window!.rootViewController as! UITabBarController
        
        /* This is the controller on the third tab*/
        let splitViewController = tabBarController.viewControllers![2] as! UISplitViewController
        
        /* The split view controller has two navigation controllers, the first one is for the Master View, the second one is for the Detail View */
        let navControllerForMasterView = splitViewController.viewControllers.first as! UINavigationController
        let navControllerFordetailViewController = splitViewController.viewControllers.last as! UINavigationController
        
        /* The table view controller is the first or top controller of the nav controller for the master view */
        let masterViewController = navControllerForMasterView.topViewController as! NewsViewController
        
        /* The detail view controller is the first or top controller of the nav controller for detail view */
        let detailViewController = navControllerFordetailViewController.topViewController as! NewsDetailViewController
        
        /* Grab a default news from the model */
        let defaultNews = NewsService.sharedInstance.getDefaulNews()
        
        /* Set this as the default news to display in both the table view and detail view */
        masterViewController.actualNews = defaultNews
        detailViewController.news = defaultNews
        
        /* Set the delegate in the table view to point to the detail view */
        masterViewController.delegate = detailViewController
        
        detailViewController.navigationItem .leftItemsSupplementBackButton = true
        detailViewController.navigationItem .leftBarButtonItem = splitViewController.displayModeButtonItem
        
        return true
        
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

