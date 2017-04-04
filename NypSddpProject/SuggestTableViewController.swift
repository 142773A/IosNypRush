//
//  SuggestTableViewController.swift
//  NypSddpProject
//
//  Created by Foxlita on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit


class SuggestTableViewController: UITableViewController {


    
    var suggestList : [SuggestFriend] = []
    var userList: User?
    var profileList : Profile?
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        suggestList = FriendDataManager.loadAllSuggestFriend()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        animateTable()
        
    }
    
    func animateTable() {
  
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: SuggestTableViewCell = a as! SuggestTableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
        
              tableView.reloadData()
    }

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return suggestList.count;
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : SuggestTableViewCell = tableView.dequeueReusableCell (withIdentifier: "SuggestTableViewCell", for: indexPath)
            as! SuggestTableViewCell
        
        let p = suggestList[indexPath.row]
        let friendsId3 = String(p.SenderUserId)
   
       
        userList = FriendDataManager.loadUserByUserId(userId: "\(friendsId3)")
        
        profileList = FriendDataManager.loadProfileByUserId(userId: "\(friendsId3)")
        
        cell.nameLabel.text = userList?.name
        
        cell.schImage.image = UIImage(named:(profileList?.ProfileImg)!)
        
        
        cell.requestBtn.tag = (p.SuggestId);
        
        cell.requestBtn.addTarget(self, action: "addRequest:", for: UIControlEvents.touchUpInside)
    
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

    
    
    
   
    
    @IBAction func addRequest(_ sender: AnyObject) {
        
        
        let refreshAlert = UIAlertController(title: "Add Friend", message: "Send friend request ? ", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            
            
            
            //friend request id
            let buttonRow = sender.tag!
            
            //retrieve frend reuest based on the id
           
            let tempFriendRequest =  FriendDataManager.loadSuggestFriendBySuggestId(friendSuggestId: "\(buttonRow)")[0]
            

            let userId = UserDefaults.standard.integer(forKey: "userId")
            //insert the friendrequest id
            let list = FriendDataManager.loadAllFriendRequest()
            let friendId = list[list.count-1].FriendRequestId + 1
            
            let tempFriend = FriendRequest(FriendRequestId: friendId, SenderUserId:userId, RecipentUserId: tempFriendRequest.SenderUserId)
            let check = FriendDataManager.insertNewFriendRequestRecord(FriendRequest: tempFriend)
            
            if(check == true){
                print("Sucess in request")
                
                //delete the record in the friend request table
           //     FriendDataManager.DeleteSuggestFriend(suggestId: "\(buttonRow)")
                
           //     self.suggestList = FriendDataManager.loadAllSuggestFriend()
           //     self.tableView.reloadData()
               
            }
            
            self.tableView.reloadData()
            
            print("Request Send \(buttonRow)")
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Request Cancel")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        

        
        
        
    }
    
    
    
    
    
    
    
    
    
}
