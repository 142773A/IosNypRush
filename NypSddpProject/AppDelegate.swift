//
//  AppDelegate.swift
//  NypSddpProject
//
//  Created by iOS on 2/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import UserNotifications

var badgeNumber = Int() //for notification badge number


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    //let loginName = UserDefaults.standard.string(forKey: "username")
    //let loginId = UserDefaults.standard.integer(forKey: "loginId")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyAsLbmo9Fl7Mz4zlABOqZmNEplsIXepifw")
        GMSPlacesClient.provideAPIKey("AIzaSyAsLbmo9Fl7Mz4zlABOqZmNEplsIXepifw")
        
        //        if (UIApplication
        //            .instancesRespond(to: #selector( UIApplication.registerUserNotificationSettings)))
        //        {
        //            let notificationSettings =
        //                UIUserNotificationSettings(
        //                    types: [.alert, .badge, .sound], categories: nil)
        //            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        //
        //        }
       
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge])
            {
                (granted, error) in
                print("Access granted: \(granted.description)")
            }
            
            let optionOne = UNNotificationAction(identifier: "optionone", title: "Yes", options: [.foreground])
            let optionTwo = UNNotificationAction(identifier: "optionTwo", title: "No", options: [.foreground])
            let optionThree = UNNotificationAction(identifier: "optionThree", title: "Maybe", options: [.foreground])
            
            let notificationCategory = UNNotificationCategory(
                identifier: "notificationCategory",
                actions: [optionOne, optionTwo, optionThree],
                intentIdentifiers: [],
                options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([notificationCategory])
            
        } else {
            // Fallback on earlier versions
        }
        application.applicationIconBadgeNumber = 0;
        
        return true
    }
    
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        
        let state = application.applicationState
        // We will want to show an alert only when the
        // application is still running as a foreground
        // app when the notification is received. //
        if(state == UIApplicationState.active) {
            //
            //            let banner = Banner(title: "", subtitle: notification.alertBody, image: UIImage(named: "ICircle-icons-running.svg copy"), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
            //            banner.dismissesOnTap = true
            //            banner.show(duration: 3.0)
            //
            //            let alert = UIAlertController( title: "", message: notification.alertBody, preferredStyle: .alert)
            //            //alert.addAction(UIAlertAction(title: "", style: .default, handler: nil))
            //            // Gets the topmost visible view controller
            //            //
            //
            //            var topViewController = self.window!.rootViewController!
            //
            //            while (topViewController.presentedViewController != nil)
            //            {
            //                topViewController = topViewController.presentedViewController!;
            //            }
            //            // Present the alert on top of the topmost // visible controller
            //            topViewController.present(alert, animated: true, completion: nil)
            ////
            //application.applicationIconBadgeNumber = badgeNumber;
            
            print("Received Local Notification:")
            print(notification.alertBody)
            
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        print("application will resign")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("did enter backgrounds")
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("will enter foreground")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("application did active")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("application terminate")
        
    }
}
