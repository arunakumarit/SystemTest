//
//  AppDelegate.swift
//  SystemTest
//
//  Created by tummaa1 on 07/05/21.
//  Copyright © 2021 tummaa1. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let frontNavigationController: UINavigationController
        let rearNavigationController: UINavigationController
        let revealController = SWRevealViewController()
        var mainRevealController = SWRevealViewController()
        
        var frontViewController: UIViewController!
        let rearViewController: UIViewController!
        
        let storyBoard = UIStoryboard(name: StoryBoardName.kMainSB.rawValue, bundle: nil)
        frontViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.HomeVCID.rawValue)
        rearViewController = storyBoard.instantiateViewController(withIdentifier: StoryBoardID.SettingsVCID.rawValue)as? SettingsVC
        frontNavigationController =  UINavigationController(rootViewController: frontViewController)
        rearNavigationController = UINavigationController(rootViewController: rearViewController)
        revealController.frontViewController = frontNavigationController
        revealController.rearViewController = rearNavigationController
        revealController.rearViewRevealWidth = frontViewController.view.frame.width-70
        mainRevealController  = revealController
        self.window?.rootViewController = mainRevealController
        
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

