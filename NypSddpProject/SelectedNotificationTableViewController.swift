//
//  SelectedNotificationTableViewController.swift
//  NypSddpProject
//
//  Created by iOS on 25/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class SelectedNotificationTableViewController: UITableViewController {
    
    @IBOutlet var selectedNotificationTableView: UITableView!
    
    var notificationCategoryId : Int!
    var notificationCategoryName: String!
    
    var tempNotificationList : [Notification] = []
    var notificationList : [Notification] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        self.navigationItem.title = "\((notificationCategoryName)!)"
        
        loadUserNotification()
        
        selectedNotificationTableView.tableFooterView = UIView()
    }
    
    func loadUserNotification()
    {
        let loginId = UserDefaults.standard.integer(forKey: "userId")
        
        tempNotificationList = NotificationDataManager.loadUserNotification(userId: "\(loginId)", notificationId: "\(notificationCategoryId!)")
        
        print(tempNotificationList)
        
        //sort comment date in ascending
        tempNotificationList.sort(by: { $0.convertedDateToNotified.compare($1.convertedDateToNotified) == .orderedDescending })
        
        //retrieve the date and sort thr list
        for item in tempNotificationList
        {
            let testDate = (item.convertedDateToNotified)!
            let epochTime: TimeInterval = Double(testDate)!
            let date = Date(timeIntervalSince1970: epochTime)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy hh:mm"
            
            let formatedDate = dateFormatter.string(from: date)
            //print(formatedDate)
            
            let tempData = item
            item.convertedDateToNotified = "\(formatedDate)"
            
            notificationList.append(tempData)
            
        }
        
        
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 0
    //    }
    //
    
    
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
        
        
        //        if(segue.identifier == "ThreadDetailsTableViewController") {
        //
        //
        //
        //            let c = segue.destination as! ThreadDetailsTableViewController
        //
        //
        //            let indexPath = self.selectedNotificationTableView.indexPathForSelectedRow
        //
        //            if  (indexPath != nil){
        //
        //                let item = notificationList[indexPath!.row]
        //
        //                let postId = item.postId!
        //
        //                let tempPost = PostDataManager.loadPostOnPostId(postId: "\(postId)")
        //
        //                var post : Post
        //
        //                let epochTime: TimeInterval = Double(tempPost.convertedPostDate)!
        //                let date = Date(timeIntervalSince1970: epochTime)
        //
        //                let dateFormatter = DateFormatter()
        //                dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
        //
        //                let formatedDate = dateFormatter.string(from: date)
        //                //print(formatedDate)
        //
        //                let tempData = tempPost
        //                tempPost.convertedPostDate = "\(formatedDate)"
        //
        //                post = tempPost
        //                c.post = post
        //
        //            }
        //        }
        
    //}
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThreadDetailsTableViewController") as? ThreadDetailsTableViewController
        {
            let indexPath = self.selectedNotificationTableView.indexPathForSelectedRow
            
            let item = notificationList[indexPath!.row]
            
            let postId = item.postId!
            
            let tempPost = PostDataManager.loadPostOnPostId(postId: "\(postId)")
            
            var post : Post
            
            let epochTime: TimeInterval = Double(tempPost.convertedPostDate)!
            let date = Date(timeIntervalSince1970: epochTime)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy hh:mm:ss"
            
            let formatedDate = dateFormatter.string(from: date)
            //print(formatedDate)
            
            let tempData = tempPost
            tempPost.convertedPostDate = "\(formatedDate)"
            
            post = tempPost
            controller.post = post
            
            
            //set tab bar index to 1
            //tabBarController?.selectedIndex = 1
            
            
            self.navigationController!.pushViewController(controller, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notificationList.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0,y: 0,width: self.tableView.frame.width, height: 35))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel(frame: CGRect(x: 16,y: 3,width: 222,height: 21))
        
        label.font =  UIFont.boldSystemFont(ofSize: 15.0)
        
        label.textColor = UIColor.lightGray
        
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        view.addSubview(label)
        
        
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var title : String
        
        if notificationList.count == 0
        {
            title = "No notifications"
        }
        else
        {
            title = ""
        }
        
        return title
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : SelectedNotificationTableViewCell = selectedNotificationTableView.dequeueReusableCell(withIdentifier: "SelectedNotificationTableViewCell", for: indexPath) as! SelectedNotificationTableViewCell
        
        let item = notificationList[indexPath.row]
        
        cell.dateLB.text = item.convertedDateToNotified!
        
        cell.descriptionLB.text = item.notifDesc!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.delete)
        {
            let notification = notificationList[(indexPath as NSIndexPath).row]
            
            let notificationId = notification.notificationId!
            let commentId = notification.commentId!
            let userId = notification.userId!
            
            
            //DataManager.deleteMovie(movie)
            notificationList.remove(at: (indexPath as NSIndexPath).row)
            
            selectedNotificationTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            
            
            let deleteResults = NotificationDataManager.deleteNotification(
                notification: Notification(
                    notificationId: notificationId,
                    commentId: commentId,
                    userId : userId))
            
            
            if deleteResults == true
            {
                print("success")
                
                //remove all list
                self.tempNotificationList.removeAll()
                self.notificationList.removeAll()
                
                //reload again
                self.loadUserNotification()
                
            }
            
        }
    }
    
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
    
}
