//
//  AppDelegate.swift
//  MisionMujer
//
//  Created by Gonzalo Urroz on 2/9/18.
//  Copyright © 2018 Gonzalo Urroz. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

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


    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "MyMoviesSolution")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

