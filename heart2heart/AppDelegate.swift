//
//  AppDelegate.swift
//  heart2heart
//
//  Created by Tega Esabunor on 27/7/17.
//  Copyright © 2017 Tega Esabunor. All rights reserved.
//

import UIKit
import Parse
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let shortcutItem = launchOptions?[UIApplicationLaunchOptionsKey.shortcutItem]
        if let shortcutItem = shortcutItem as? UIApplicationShortcutItem {
            print(shortcutItem.type)
        }
        let configuration = ParseClientConfiguration {
            $0.applicationId = "myAppId"
            $0.clientKey = ""
            $0.server = "https://parser-server11.herokuapp.com/parse"
        }
        Parse.initialize(with: configuration)
        
        self.window = self.window ?? UIWindow() //*
        self.window?.backgroundColor = .white //*
        let data = [Any]()
        let vc1 = ViewController()
        let vc2 = TableViewController()
        let vc3 = SecondPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        let vc4 = UINavigationController(rootViewController: FontTableViewController(style: .grouped))
        vc4.navigationBar.prefersLargeTitles = true
        vc3.setViewControllers([PictureViewController()], direction: .forward, animated: true, completion: nil)
        let nav = NavigationViewController(rootViewController: vc2)
       
        vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 10)
        vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 11)
        vc3.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 12)
        vc4.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 13)
        
        vc2.tabBarItem.badgeValue = "9"
        let tbc = UITabBarController()
        tbc.viewControllers = [vc1, nav, vc3, vc4]
        tbc.selectedIndex = 1
        var rootVC : UIViewController
        if let _ = UserDefaults.standard.string(forKey: "Token") {
            rootVC = tbc
        } else {
             UserDefaults.standard.set("Token", forKey: "Token")
            rootVC = UIViewController()
            
        }
        var query = PFQuery(className: "Person")
        query.findObjectsInBackground {
            if $1 != nil {
                print($1)
            } else {
                let objects = $0 as! [PFObject]
                let vc4 = PageViewController()
                vc4.setViewControllers([PersonDetailViewController(objectId: objects[0].objectId!)], direction: .forward, animated: true, completion: nil)
                vc4.setPFObjects(objects)
                vc4.dataSource = vc4
                vc4.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 13)
                tbc.viewControllers?.append(vc4)
            }
        }
        self.window?.rootViewController = rootVC //*
        self.window?.makeKeyAndVisible() //*
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
        { (granted, error) in
        }
            
        UIApplication.shared.applicationIconBadgeNumber = 23
        let icon = UIApplicationShortcutIcon(type: .location)
        let shortcut1 = UIApplicationShortcutItem(type: "Type1?", localizedTitle: "type one", localizedSubtitle: "type one sub", icon: icon, userInfo: nil)
        UIApplication.shared.shortcutItems = [shortcut1]
        return true //*
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

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
         return .portrait
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(deviceToken.description)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        // for completing shortcut items
    }
}

