//
//  NewThreadViewController.swift
//  NypSddpProject
//
//  Created by ℜ . on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit
import AssetsLibrary

class NewThreadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var challenge : Challenge!
    
    var newThread : Post!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    
    @IBOutlet weak var pictureButton: UIButton!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTF: UITextField!
    
    var imageName : String = ""
    var imageFile : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.scrollView.contentSize = CGSize(width: 100, height: 400)
        
        self.navigationItem.title = "\((challenge!.challengeName)!)"
        
        //image.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pictureHandler(_ sender: AnyObject)
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        // Setting this to true allows the user to crop and scale
        // the image to a square after the image is selected.
        //
        picker.allowsEditing = true
        picker.sourceType =
            UIImagePickerControllerSourceType.photoLibrary
        
        self.present(
            picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        
        
        let imageUrl      = info[UIImagePickerControllerReferenceURL] as! NSURL
        imageName         = imageUrl.lastPathComponent!
        imageFile         = info[UIImagePickerControllerOriginalImage]as! UIImage
        
        imageTF.text = "\(imageName)"
        
        
        self.dismiss(animated: true, completion: nil);
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true)
    }
    
    @IBAction func saveHandler(_ sender: AnyObject) {
        
        let title = titleTF.text!
        let desc = descriptionTF.text!
        
        let currentTime = NSDate().timeIntervalSince1970
        let epochTime: TimeInterval = currentTime
        let date = Date(timeIntervalSince1970: epochTime)
        
        
        if title == "" || desc == ""
        {
            let alert = UIAlertController(
                title: "Please enter all fields",
                message: "",
                preferredStyle:
                UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: UIAlertActionStyle.default,
                                          handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        else
        {
            let userDirectoryPath  = "forum"
            
            var imageNamePath : String = ""
            
            if imageTF.text != ""
            {
                imageNamePath = "forum_\(title).jpg"
                createDirectory(directoryPathName: userDirectoryPath)
                // save image
                saveImageDocumentDirectory(image: imageFile!, imageName: imageNamePath, directoryPathName: userDirectoryPath)
            }
            
            print("insert post")
            var loginId = UserDefaults.standard.integer(forKey: "userId")
            //insert comment
            let insertPostResult = PostDataManager.insertPost(post:
                Post(postTitle: title, postDesc: desc, postImage: imageNamePath, postDate: currentTime, userId: loginId, challengeId: challenge!.challengeId!))
            
            if(insertPostResult == true)
            {
                print("Success")
                print(title, desc, imageNamePath, date, loginId, challenge!.challengeId!)
                
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers
                for aViewController in viewControllers {
                    if aViewController is ThreadsTableViewController {
                        self.navigationController!.popToViewController(aViewController, animated: true)
                    }
                }
                
            }
            
        }
        
    }
    
    //create a directory first
    
    func createDirectory(directoryPathName : String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryPathName)
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Directory already created.")
        }
    }
    
    
    
    // save image document
    func saveImageDocumentDirectory(image : UIImage, imageName : String, directoryPathName: String){
        let fileManager = FileManager.default
        
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(directoryPathName)
        let finalPath = paths + "/" + imageName
        print(finalPath)
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        fileManager.createFile(atPath: finalPath as String, contents: imageData, attributes: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
