//
//  ThirdViewController.swift
//  NypSddpProject
//
//  Created by iOS on 2/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import UserNotifications

class ThirdViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //hohoh
        setDelegate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
    }
    
    @IBAction func unwindToThisNotificationController(segue: UIStoryboardSegue) {
        print("Returned from detail screen")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDelegate()
    {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
    }

}




//extend third view controller to notification delegate
extension ThirdViewController:UNUserNotificationCenterDelegate{
    
    
    //This is key callback to present notification while the app is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("")
        print("thirdViewController")
        print("will present")
        let userInfo = notification.request.content.userInfo
        let notificationId = notification.request.content.userInfo["notificationId"].unsafelyUnwrapped
        let commentId = notification.request.content.userInfo["commentId"].unsafelyUnwrapped
        let tempUserId = "\(notification.request.content.userInfo["userId"].unsafelyUnwrapped)"
        let notificationName = "\(notification.request.content.userInfo["notificationName"].unsafelyUnwrapped)"
        
        badgeNumber = notification.request.content.badge as! Int
        
        let userId = Int(tempUserId)
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        
        print("userInfo", userInfo)
        print("commentId", commentId)
        print("notificationId", notificationId)
        print("notificationName", notificationName)
        print("userId", userId!)
        print("")
        print("")
        print("loginId", loginId, "userId", userId!)
        
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        
        //if current login user has the same notificationId ignore notification
        if loginId == userId!
        {
            completionHandler([])
            
            print("Notification being triggered same Id")
        }
        else if loginId > 0
        {
            
            completionHandler( [.alert,.sound,.badge])
            
            if badgeNumber == 0
            {
                tabBarController?.tabBar.items?[2].badgeValue = nil
                UIApplication.shared.applicationIconBadgeNumber = 0
            }
            else
            {
                tabBarController?.tabBar.items?[2].badgeValue = "\(badgeNumber)"
                UIApplication.shared.applicationIconBadgeNumber = badgeNumber
            }
            
            
            
            print("Notification being triggered not same Id")
            
        }
        else
        {
            completionHandler([])
            
            print("Notification triggered unknown error")
        }
        
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("")
        print("thirdViewController")
        print("did receive")
        let userInfo = response.notification.request.content.userInfo
        let tempNotificationId = "\(userInfo["notificationId"].unsafelyUnwrapped)"
        let tempCommentId = "\(userInfo["commentId"].unsafelyUnwrapped)"
        let tempUserId = "\(userInfo["userId"].unsafelyUnwrapped)"
        
        let tempNotificationName = "\(userInfo["notificationName"].unsafelyUnwrapped)"
        
        badgeNumber = response.notification.request.content.badge as! Int
        
        let userId = Int(tempUserId)
        let notificationId = Int(tempNotificationId)
        let commentId = Int(tempCommentId)
        let notificationName = String(tempNotificationName)
        
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        
        print("userInfo", userInfo)
        print("commentId", commentId!)
        print("notificationId", notificationId!)
        print("notificationName", notificationName!)
        print("userId", userId!)
        print("")
        print("")
        print("loginId", loginId, "userId", userId!)
        //You can either present alert ,sound or increase badge while the app is in foreground too with ios 10
        //to distinguish between notifications
        
        //if current login user has the same notificationId ignore notification
        if loginId == userId!
        {
            //completionHandler()
            
            print("Tapped in notification same Id")
        }
            //user is logged in
        else if loginId > 0
        {
            
            //completionHandler()
            
            if badgeNumber == 0
            {
                tabBarController?.tabBar.items?[2].badgeValue = nil
            }
            else
            {
                tabBarController?.tabBar.items?[2].badgeValue = "\(badgeNumber)"
            }
            
            
            if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectedNotificationTableViewController") as? SelectedNotificationTableViewController
            {
                
                controller.notificationCategoryId = notificationId!
                controller.notificationCategoryName = notificationName!
                
                //set tab bar index to 2
                self.tabBarController?.selectedIndex = 2
                
                self.navigationController!.pushViewController(controller, animated: true)
            }
            
            print("Tapped in notification not same Id")
        }
        else
        {
            print("Tapped in notification no loginId")
        }
    }
    
    
    
}
