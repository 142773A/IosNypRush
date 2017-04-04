//
//  FriendViewController.swift
//  NypSddpProject
//
//  Created by iOS on 3/2/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var friendSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var suggestContainerView: UIView!
    @IBOutlet weak var requestContainerView: UIView!
    @IBOutlet weak var friendContainerView: UIView!
    
   
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func friendSegmentedControlAction(_ sender: AnyObject) {
        switch (sender as AnyObject).selectedSegmentIndex {
            case 0 :
            friendContainerView.isHidden = false
            requestContainerView.isHidden = true
            suggestContainerView.isHidden = true
            
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let vc = self.childViewControllers[2] as! FriendTableViewController
            vc.friendList = FriendDataManager.loadAllFriendBySenderIdMe(id: "\(userId)")
            vc.tableView.reloadData()
            print("dsfsdfdsf")
            
            case 1 :
            friendContainerView.isHidden = true
            requestContainerView.isHidden = false
            suggestContainerView.isHidden = true
            
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let vc = self.childViewControllers[1] as! RequestTableViewController
            vc.requestList = FriendDataManager.loadFriendRequestByRecipentIdMe(id: "\(userId)")
            
            case 2 :
            friendContainerView.isHidden = true
            requestContainerView.isHidden = true
            suggestContainerView.isHidden = false
            
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let vc = self.childViewControllers[0] as! SuggestTableViewController
            vc.suggestList = FriendDataManager.loadAllSuggestFriend()
            
            default: break;
        }
    }
}
