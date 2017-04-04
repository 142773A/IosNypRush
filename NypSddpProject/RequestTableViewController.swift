//
//  RequestTableViewController.swift
//  NypSddpProject
//
//  Created by Foxlita on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit



class RequestTableViewController: UITableViewController {
    
    
    var requestList : [FriendRequest] = []
    var user : User?
    var profile : Profile?
    var deleteRequest : FriendRequest?
    

    
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
 
        let userId = UserDefaults.standard.integer(forKey: "userId")
        requestList = FriendDataManager.loadFriendRequestByRecipentIdMe(id: "\(userId)")
                

    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
        
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: RequestTableViewCell = a as! RequestTableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return requestList.count;
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell : RequestTableViewCell = tableView.dequeueReusableCell (withIdentifier: "RequestTableViewCell", for: indexPath)
            as! RequestTableViewCell
        
        let p = requestList[indexPath.row]
        let friendsId2 = String(p.SenderUserId)

        let userId = UserDefaults.standard.integer(forKey: "userId")
        user = FriendDataManager.loadUserByUserId(userId: "\(friendsId2)")
        
        profile = FriendDataManager.loadProfileByUserId(userId: "\(friendsId2)")
        
        cell.nameLabel.text = user?.name
        
        cell.schImage.image = UIImage(named:(profile?.ProfileImg)!)
        
        cell.acceptBtn.tag = (p.FriendRequestId);

        cell.acceptBtn.addTarget(self, action: "acceptClick:", for: UIControlEvents.touchUpInside)
        
        print(" Success ")
        
        return cell
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    
    
    @IBAction func acceptClick(_ sender:UIButton) {
        
        
        let refreshAlert = UIAlertController(title: "Accept Friend", message: "Add this user as friend ? ", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            //friend request id
             let buttonRow = sender.tag
            
            //retrieve frend reuest based on the id
            let tempFriendRequest = FriendDataManager.loadFriendRequestByFriendRequestId(friendRequestId: "\(buttonRow)")[0]
            
            //insert the friend id
            let userId = UserDefaults.standard.integer(forKey: "userId")
            //get the last index and create it
            let list = FriendDataManager.loadAllFriend()
            let friendId = list[list.count-1].FriendId + 1
            let tempFriend = Friend(FriendId: friendId, SenderUserId: tempFriendRequest.RecipentUserId, RecipentUserId: tempFriendRequest.SenderUserId)
            let check = FriendDataManager.insertNewFriendRecord(Friend: tempFriend)
            
            if(check == true){
                print("Sucess in creating")
                
                //delete the record in the friend request table
                FriendDataManager.DeleteSelectRequest(friendRequestId: "\(tempFriendRequest.FriendRequestId)")
                self.requestList = FriendDataManager.loadFriendRequestByRecipentIdMe(id: "\(userId)")
                self.tableView.reloadData()
            }
            

         
            print("Request Accept \(buttonRow)")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Request Cancel")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let d = requestList[indexPath.row]
            requestList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    

    

    
    
    
}
