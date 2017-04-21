//
//  AppDelegate.swift
//  Alarm
//
//  Created by samuel on 28/03/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit
import Dip

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Create the container
    private let container = DependencyContainer { container in
        
        // Register some factory. ServiceImp here implements protocol Service
        container.register { UsersDataSourceMock() as UsersDataSourceProtocol }
        
        
        //container.register { "test" as Url }
        
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        AlarmeSystem.shared.userService = try! container.resolve() as UsersDataSourceProtocol
        
        //SplitViewControllerId
        
        let storyboard = UIStoryboard(name: "StoryboardIpad", bundle: nil)
        let splitViewController = storyboard.instantiateViewController(withIdentifier :"SplitViewControllerId") as! UISplitViewController
        let leftNavController = splitViewController.viewControllers.first as! UINavigationController
        
        let masterViewController = leftNavController.topViewController as! ContactsTableViewController
        
        let rightNavController = splitViewController.viewControllers.last as! UINavigationController
        let detailViewController = rightNavController.topViewController as! ViewController
        detailViewController.delegate = masterViewController
        
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        
        /*
        let firstTopic = masterViewController.
        detailViewController.monster = firstMonster*/
        /*
        let rightNavController = splitViewController.viewControllers.last as! UINavigationController
        let detailViewController = rightNavController.topViewController as! DetailViewController
        */
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

