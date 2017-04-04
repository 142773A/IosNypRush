//
//  PhotoArtSegmentTableViewController.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PhotoArtSegmentTableViewController: UITableViewController {
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet var photoArtTableView: UITableView!
    var photoArtList : [PhotoArt] = []
     var selectedUser : User?
    var userProgressList : [UserPhotoArtProgress] = []
    var checkFromQuestion = false

    var filledUpArrDictionary = [Int: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationController?.isNavigationBarHidden = false
        
        
        //get the user that was used
        selectedUser = UserDataManager.loadUserByUsername(username: UserDefaults.standard.string(forKey: "username")!)
        loadUserPhotoArtProgress(user: selectedUser!)
    
        
        photoArtTableView.tableFooterView = UIView()
        photoArtTableView.tableFooterView?.backgroundColor = UIColor.groupTableViewBackground
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        if(checkFromQuestion == true){
            print("OMG Will Appear")
        }
    }
    
    @IBAction func unwindToThisPhotoSegmentViewController(segue: UIStoryboardSegue) {
        print("Returned from detail screen")

    
        if segue.source is PhotoArtQuestionTableViewController {
        
            self.checkFromQuestion = true
            print("OMG CHECK")
            //get the user that was used
            selectedUser = UserDataManager.loadUserByUsername(username: UserDefaults.standard.string(forKey: "username")!)
            loadUserPhotoArtProgress(user: selectedUser!)
            photoArtTableView.reloadData()
        
        }
        else{
            self.checkFromQuestion = false
        }
    }
 
    func loadUserPhotoArtProgress(user : User){
        //check whether there is a record of user inside
        
        let userProgress = PhotoArtUserDataManager.loadPhotoArtUserByUserId(
            userId: "\(user.userId)")
        
        if(userProgress != nil){
            let currentProgress = userProgress as! UserPhotoArt
            //if user have progress, retrive all the question at the current segment
            photoArtList = PhotoArtDataManager.loadPhotoArtBySegmentId(
                segmentId: currentProgress.segmentId)
            
            //load the total based on segment
            let tempSegment = PhotoArtDataManager.loadPhotoArtSegmentsById(segmentId: currentProgress.segmentId)
            //then go to the user photo art progress table to retrieve user progress
            self.userProgressList = PhotoArtUserDataManager.loadPhotoArtUsersProgressByUserId(userId: "\(selectedUser!.userId)")
            progressLabel.text = "\(currentProgress.completionRate) / \(tempSegment.totalCubes)"
            
        }
        else{
            // if there is no progress, load the question of the first segment
            photoArtList = PhotoArtDataManager.loadPhotoArtBySegmentId(segmentId: 1)
            
            //retrive all the user records
            let allUsersPhotoArt = PhotoArtUserDataManager.loadPhotoArtUsers()
    
            //create a record of the user in the User Photo Art Table
            let newUser = UserPhotoArt(id: allUsersPhotoArt.count + 1,
                                       segmentId: 1,
                                       colNo: 0,
                                       rowNo: 0,
                                       completionRate: 0,
                                       userId: user.userId,
                                       photoArtId: 1,
                                       totalScore: 0.0,
                                       completed: 0)
            
            let result = PhotoArtUserDataManager.insertNewRecord(userPhotoArt: newUser)
            
            if(result == true){
                print("Successfully added new user photo art record")
                
                //load the total based on segment
                let tempSegment = PhotoArtDataManager.loadPhotoArtSegmentsById(segmentId: 1)
                 progressLabel.text = "0 / \(tempSegment.totalCubes)"
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : PhotoArtSegmentTableViewCell = photoArtTableView.dequeueReusableCell (withIdentifier: "PhotoArtTableViewCell", for: indexPath)
            as! PhotoArtSegmentTableViewCell
        
        // each cell there is 7 columns (7 row x 7 columns)
        
        // for the first row and last row it always the back ground
        if(indexPath.row == 0 || indexPath.row == 6){
            cell.imageView1.image = UIImage(named: "photo_art_background")
            cell.imageView2.image = UIImage(named: "photo_art_background")
            cell.imageView3.image = UIImage(named: "photo_art_background")
            cell.imageView4.image = UIImage(named: "photo_art_background")
            cell.imageView5.image = UIImage(named: "photo_art_background")
            cell.imageView6.image = UIImage(named: "photo_art_background")
            cell.imageView7.image = UIImage(named: "photo_art_background")
        }else{
            //if is not first row or last row
            let rowNumber = indexPath.row
            var tempList : [PhotoArt] = []
            cell.imageView1.image = UIImage(named: "photo_art_background")
            cell.imageView7.image = UIImage(named: "photo_art_background")
            for item in photoArtList{
                if((item.rowNo-1) == rowNumber){
                    //if item row number is the current cell row index, add to the temp list
                    
                    tempList.append(item)
                }
            }
            
            //loop through the temp list to check whether is user 
            //suppose to answer or is it a background image
            let colCounter = 6
            
            for i in 1 ..< colCounter{
                for a in 0 ..< tempList.count{
                    if(tempList[a].colNo == (i+1)){
                        if ( tempList[a].colNo == 2){
                            var check = false
                            for item in userProgressList{
                                if(item.colNo == 2 && item.rowNo == rowNumber + 1){
                                    getImage(filePath: item.imageUrl, imageView: cell.imageView2)
                                    check = true
                                   
                                    
                                    filledUpArrDictionary[(tempList[a].photoArtId)] = item.imageUrl
                                 
                                    
                                }
                            }
                            if(check == false){
                                cell.imageView2.image = UIImage(named: "question_mark_box")
                            }
                            
                            assignClickToImageView(imageViewAssigned: cell.imageView2,
                                                   tagNumber:tempList[a].photoArtId)
                            
                        }
                        else if ( tempList[a].colNo == 3){
                            var check = false
                            for item in userProgressList{
                                if(item.colNo == 3 && item.rowNo == rowNumber + 1){
                                    getImage(filePath: item.imageUrl, imageView: cell.imageView3)
                                    check = true
                                    
                                    filledUpArrDictionary[(tempList[a].photoArtId)] = item.imageUrl
                                }
                            }
                            if(check == false){
                                cell.imageView3.image = UIImage(named: "question_mark_box")
                            }
                            
                            assignClickToImageView(imageViewAssigned: cell.imageView3,
                                                   tagNumber:tempList[a].photoArtId)
                        }
                        else if ( tempList[a].colNo == 4){
                            var check = false
                            for item in userProgressList{
                                if(item.colNo == 4 && item.rowNo == rowNumber + 1){
                                    getImage(filePath: item.imageUrl, imageView: cell.imageView4)
                                    check = true
                                    
                                     filledUpArrDictionary[(tempList[a].photoArtId)] = item.imageUrl
                                }
                            }
                            if(check == false){
                                cell.imageView4.image = UIImage(named: "question_mark_box")
                            }
                            
                            assignClickToImageView(imageViewAssigned: cell.imageView4,
                                                   tagNumber:tempList[a].photoArtId)
                        }
                        else if ( tempList[a].colNo == 5){
                            var check = false
                            for item in userProgressList{
                                if(item.colNo == 5 && item.rowNo == rowNumber + 1){
                                    getImage(filePath: item.imageUrl, imageView: cell.imageView5)
                                    check = true
                                    
                                     filledUpArrDictionary[(tempList[a].photoArtId)] = item.imageUrl
                                }
                            }
                            if(check == false){
                                cell.imageView5.image = UIImage(named: "question_mark_box")
                            }
                            
                            assignClickToImageView(imageViewAssigned: cell.imageView5,
                                                   tagNumber:tempList[a].photoArtId)
                        }
                        else if ( tempList[a].colNo == 6){
                            var check = false
                            for item in userProgressList{
                                if(item.colNo == 6 && item.rowNo == rowNumber + 1){
                                    getImage(filePath: item.imageUrl, imageView: cell.imageView6)
                                    check = true
                                    
                                     filledUpArrDictionary[(tempList[a].photoArtId)] = item.imageUrl
                                }
                            }
                            if(check == false){
                                cell.imageView6.image = UIImage(named: "question_mark_box")
                            }
                            assignClickToImageView(imageViewAssigned: cell.imageView6,
                                                   tagNumber:tempList[a].photoArtId)
                        }
                        tempList.remove(at: a)
                        
                        
                        break
                    }
                }
            }
            
            for b in 2 ... colCounter{
                
                if (b == 2 && cell.imageView2.image == nil){
                    cell.imageView2.image = UIImage(named: "photo_art_background")
                }
                else if (b == 3 && cell.imageView3.image == nil){
                    cell.imageView3.image = UIImage(named: "photo_art_background")
                }
                else if (b == 4 && cell.imageView4.image == nil){
                    cell.imageView4.image = UIImage(named: "photo_art_background")
                }
                else if (b == 5 && cell.imageView5.image == nil){
                    cell.imageView5.image = UIImage(named: "photo_art_background")
                }
                else if (b == 6 && cell.imageView6.image == nil){
                    cell.imageView6.image = UIImage(named: "photo_art_background")
                }
                
                
            }
            
        }
        
        return cell
    }
    
    func assignClickToImageView(imageViewAssigned : UIImageView , tagNumber : Int){
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(sender:)))
        imageViewAssigned.isUserInteractionEnabled = true
        imageViewAssigned.addGestureRecognizer(tapGestureRecognizer)
        imageViewAssigned.tag = tagNumber
    }

    func imageTapped(sender: UITapGestureRecognizer)
    {
 
        let tag = sender.view?.tag
        // Your action
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "photoArtQuestionTableViewController") as! PhotoArtQuestionTableViewController
        
        
        for item in photoArtList {
            if(item.photoArtId == tag){
                controller.photoArtObject = item
            }
        }
        
        
        for (id, imageurl) in filledUpArrDictionary{
            if(id == tag){
                let rootPath = getImagePath(filePath: imageurl)
                let tempImg = UIImageView(image: UIImage(contentsOfFile: rootPath))
                controller.retrieveTempImage = tempImg.image
            }
        }
        
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    func getImage(filePath : String, imageView : UIImageView){
        let fileManager = FileManager.default
        let imagePAth = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filePath)
        if fileManager.fileExists(atPath: imagePAth){
            imageView.image = UIImage(contentsOfFile: imagePAth)
        }else{
            print("No Image")
            imageView.image = UIImage(named: "question_mark_box")
        }
    }
    
    func getImagePath(filePath : String) -> String{
        let fileManager = FileManager.default
        let imagePAth = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filePath)
        if fileManager.fileExists(atPath: imagePAth){
            return imagePAth
        }else{
            print("No Image")
            return ""
        }
    }
    /*


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}*/
}
