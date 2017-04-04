//
//  ForthViewController.swift
//  NypSddpProject
//
//  Created by iOS on 2/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit
import UserNotifications



class FourthViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate{


    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!

    
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var friendLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!

    
    
    var schoolList : [School] = []
    var profileList : [Profile] = []
    
    var schoolId = ""
    var teamId = ""
    // var username : [User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegate()

        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: "username")
        
        //retrieve user by username
        let userSelected = UserDataManager.loadUserByUsername(username: username!)
        nameLabel.text = userSelected.name
 
        let userId = UserDefaults.standard.integer(forKey: "userId")
        profileList = [ProfileDataManager.loadProfileByUserId(id: "\(userId)")]
        //username = [UserDataManager.loadUserByUsername2()]

        for item in profileList{
             likeLabel.text = String(item.Likes) + " Likes"
             friendLabel.text = String(item.Friends) + " Friends"
             postLabel.text = String(item.Posts) + " Post"
        
            schoolId = "\(item.SchoolId)"
            teamId = "\(item.TeamId)"
            
            var image: UIImage = UIImage(named: item.ProfileImg)!
            profileImg.image = image
            profileImg.layer.borderWidth = 8.0
            profileImg.layer.masksToBounds = false
            profileImg.layer.borderColor = UIColor(white: 0.7, alpha: 0.9).cgColor
            profileImg.layer.cornerRadius = profileImg.frame.size.width/2
            profileImg.clipsToBounds = true
            


        }
        
        showSchool()
        
        

        

        if !(UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera)) {
            // If not, we will just hide the takePicture button //
            cameraBtn.isHidden = true
        }
        
        
    }
    
    func setDelegate()
    {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        schoolLabel.alpha = 0.0
        nameLabel.alpha = 0.0
        friendLabel.alpha = 0.0
        likeLabel.alpha = 0.0
        postLabel.alpha = 0.0
        profileImg.alpha = 0.0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.profileImg.alpha = 1
            self.schoolLabel.alpha = 1
            self.nameLabel.alpha = 1
            self.friendLabel.alpha = 1
            self.likeLabel.alpha = 1
            self.postLabel.alpha = 1
            self.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    
    
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    
    func saveImageDocumentDirectory(){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("apple.jpg")
        let image = UIImage(named: "apple.jpg")
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
    }
    
    
    
    
    func showSchool(){
        
        schoolList = [ProfileDataManager.loadSchoolBySchoolId(schoolId: self.schoolId)]
        for item in schoolList{

            schoolLabel.text = String(item.SchoolShortName)
        }
    }
    
    
    
    
    @IBAction func editImage(_ sender: AnyObject) {

        let picker = UIImagePickerController(); picker.delegate = self
        // Setting this to true allows the user to crop and scale // the image to a square after the image is selected.
        //
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(
            picker, animated: true)
  
    }
    
    
    @IBAction func takeImage(_ sender: AnyObject) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        // Setting this to true allows the user to crop and scale // the image to a square after the photo is taken.
        //
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.camera
        self.present(
            picker, animated: true)
   
    }
    
    
    func imagePickerControllerDidCancel(
        _ picker: UIImagePickerController) {
        picker.dismiss(animated: true) }
    
    
    func imagePickerController(
        _ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
        [String : AnyObject])
    {
        let chosenImage : UIImage =
            info[UIImagePickerControllerEditedImage] as! UIImage
        self.profileImg!.image = chosenImage
        picker.dismiss(animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//extend fourth view controller to notification delegate
extension FourthViewController:UNUserNotificationCenterDelegate{
    
    
    //This is key callback to present notification while the app is in foreground
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        print("")
        print("fourthViewController")
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
        print("fourthViewController")
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

