//
//  LoginViewController.swift
//  NypSddpProject
//
//  Created by Foxlita on 11/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import UserNotifications



class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userText.autocapitalizationType = .allCharacters;
        userText.text = ""
        passwordText.text = ""
        
        self.userText.delegate = self
        self.passwordText.delegate = self
        
        //Add icon at textbox
        
        let leftImageView = UIImageView()
        
        leftImageView.image = UIImage(named: "User-100")
        
        let leftView = UIView()
        leftView.addSubview(leftImageView)
        
        leftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        leftImageView.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        userText.leftViewMode = .always
        userText.leftView = leftView
        
        
        let leftImageView2 = UIImageView()
        leftImageView2.image = UIImage(named: "Password-100")
        
        let leftView2 = UIView()
        leftView2.addSubview(leftImageView2)
        
        leftView2.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        leftImageView2.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        passwordText.leftViewMode = .always
        passwordText.leftView = leftView2
        
        setDelegate()
        
        
        // Do any additional setup after loading the view.
    }
    func setDelegate()
    {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func loginFunction(_ sender: AnyObject) {
        
        let username = self.userText.text?.uppercased()
        let password = self.passwordText.text
        
        
        if (username == "") {
            let alert = UIAlertView(title: "Invalid", message: "Please enter username", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if (password == "")  {
            let alert = UIAlertView(title: "Invalid", message: "Please enter password", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else {
            
            //get the user list
            
            let userTemp = UserDataManager.loadUserByUsernamePassword(username: username!, password: password!)
            
            if(userTemp != nil ){
                
                let user = userTemp as! User
                //if user exist and should only have one by right
                let alert = UIAlertView(title: "Success", message: "Welcome to NYP Rush", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                let defaults = UserDefaults.standard
                
                defaults.set(username, forKey: "username")
                defaults.set(password, forKey: "password")
                defaults.set(user.userId, forKey: "userId")
                
                self.performSegue(withIdentifier: "nextScene", sender: self)
                
                                
                
            }
            else{
                let alert = UIAlertView(title: "Invalid", message: "Wrong Username or Password,pleaase try again", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            
        }
        
    }
}


//extend login view controller to notification delegate
extension LoginViewController:UNUserNotificationCenterDelegate{
    
    
    //This is key callback to present notification while the app is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("")
        print("loginViewController")
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
            completionHandler([])
            
            //completionHandler( [.alert,.sound,.badge])
            //
            //            if badgeNumber == 0
            //            {
            //                tabBarController?.tabBar.items?[2].badgeValue = nil
            //                UIApplication.shared.applicationIconBadgeNumber = 0
            //            }
            //            else
            //            {
            //                tabBarController?.tabBar.items?[2].badgeValue = "\(badgeNumber)"
            //                UIApplication.shared.applicationIconBadgeNumber = badgeNumber
            //            }
            
            
            
            print("Notification being triggered not same Id")
            
        }
        else
        {
            completionHandler([])
            badgeNumber = 0
            print("Notification triggered unknown error")
        }
        
    }
    
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("")
        print("loginViewController")
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
            
            //            if badgeNumber == 0
            //            {
            //                tabBarController?.tabBar.items?[2].badgeValue = nil
            //            }
            //            else
            //            {
            //                tabBarController?.tabBar.items?[2].badgeValue = "\(badgeNumber)"
            //            }
            
            
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








