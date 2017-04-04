//
//  FriendTableViewController.swift
//  NypSddpProject
//
//  Created by Foxlita on 28/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit




class FriendTableViewController: UITableViewController , UISearchResultsUpdating, UISearchBarDelegate {

    
     var friendList : [User] = []
     var selectedUser : User?
     var selectedProfile : Profile?
     var deleteFriend : Friend?
    
     var friendSearchList : [User] = []
     var searchController: UISearchController!
     var shouldShowSearchResults = false
    
     var searchString = String()
     var selectedSearchUser : User?
    
     let searchBarIsHidden = true
     var timer: Timer!
     var isAnimating = false

    
     override func viewDidLoad() {
        super.viewDidLoad()
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        friendList = FriendDataManager.loadAllFriendBySenderIdMe(id: "\(userId)")
        
        
        
        configureSearchController()
     
   
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
        print("Friend Check")
         
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
            let cell: FriendTableViewCell = a as! FriendTableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
    }

    
    

    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        
        if shouldShowSearchResults {
            return friendSearchList.count
        }
        else {
            return friendList.count;
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableViewCell") as! FriendTableViewCell!
        
        let p = friendList[indexPath.row]
        
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        
        
        //selectedUser = FriendDataManager.loadUserByUserId(userId: "\(p.RecipentUserId)")
        //selectedProfile = FriendDataManager.loadProfileByUserId(userId: "\(p.RecipentUserId)")
        
        
        if shouldShowSearchResults {
            
            let n = friendSearchList[indexPath.row]
            
            selectedSearchUser = FriendDataManager.loadAllFriendBySearchResult(searchName: "\(n.name)")
            selectedProfile = FriendDataManager.loadProfileByUserId(userId: "\(n.RecipentUserId!)")
            
            cell?.friendNameLabel.text = n.name   //selectedSearchUser?.name
            cell?.friendImage.image = UIImage(named:(selectedProfile?.ProfileImg)!)
            
            
            print("Retrieve Search Data")
            
        }
        else {
            
            cell?.friendNameLabel.text = p.name //selectedUser?.name
            
            cell?.friendImage.image = UIImage(named:(p.ProfileImg)!)
            
            
            print(" Success ")
        }
        
        return cell!

    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let d = friendList[indexPath.row]
            let deleteId = String(d.FriendId)
            FriendDataManager.DeleteSelectFriend(friendId: deleteId)
            print("deleteId\(deleteId)")
            
            friendList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
            tableView.reloadData()
        
            
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
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
    

  
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        
        tableView.reloadData()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       
        if(friendSearchList.count == 0){
            shouldShowSearchResults = false;
        } else {
            shouldShowSearchResults = true;
        }
        self.tableView.reloadData()
        
        
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
       // searchController.searchBar.resignFirstResponder()
    }
    
    //
    //    func updateSearchResultsForSearchController(searchController: UISearchController) {
    //
    //    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // code here
        searchString = searchController.searchBar.text!
        
        friendSearchList = [FriendDataManager.loadAllFriendBySearchResult(searchName: "\(searchString)")]
        
        for item in friendSearchList
        {
            print(item)
        }
        
        // Filter the data array and get only those countries that match the search text.
        //        friendSearchList = friendSearchList.filter({ (selectedUser) -> Bool in
        //            let countryText: NSString = selectedUser
        //
        //            return (countryText.rangeOfString(searchString, options: NSStringCompareOptions.CaseInsensitiveSearch).location) != NSNotFound
        //        })
        if(friendSearchList.count == 0){
            shouldShowSearchResults = false;
        } else {
            shouldShowSearchResults = true;
        }
        self.tableView.reloadData()
    }
    
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        
        //tableView.tableHeaderView = searchController.searchBar
    }
    

    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if searchBarIsHidden {
             tableView.tableHeaderView = searchController.searchBar //your show search bar function
        } else {
            tableView.tableHeaderView = nil // hide
            searchController.isActive = false
        }
    }
    
    
    
    
    
}
