//
//  AppDelegate.swift
//  heart2heart
//
//  Created by Tega Esabunor on 27/7/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Parse
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = ""
            $0.server = "https://parser-server11.herokuapp.com/parse"
        }
        Parse.initialize(with: configuration)
        
        self.window = self.window ?? UIWindow()
        self.window?.backgroundColor = .white
        let vc1 = ViewController()
        let vc2 = TableViewController()
        let nav = NavigationViewController(rootViewController: vc2)
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 10)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 11)
        vc2.tabBarItem.badgeValue = "9"
        let tbc = UITabBarController()
        tbc.viewControllers = [vc1, nav]
        
        self.window?.rootViewController = tbc
        self.window?.makeKeyAndVisible()
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

