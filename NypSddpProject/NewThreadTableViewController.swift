//
//  AddForumTableViewController.swift
//  NypSddpProject
//
//  Created by ℜ . on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class NewThreadTableViewController: UITableViewController {
    
    @IBOutlet var newThreadTableView: UITableView!
    
    var postCategoryId : Int!
    
    var challengeList : [Challenge] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadChallenge()
        
        self.newThreadTableView.tableFooterView = UIView()
    }
    
    func loadChallenge()
    {
        challengeList = ChallengeDataManager.loadChallenge(categoryId: "\(postCategoryId!)")
        
        
        self.newThreadTableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return challengeList.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0,y: 0,width: self.tableView.frame.width, height: 80))
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel(frame: CGRect(x: 17,y: 3,width: 375,height: 21))
        
        label.font =  UIFont.boldSystemFont(ofSize: 15.0)
        
        label.textColor = UIColor.lightGray
        
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        view.addSubview(label)
        
        
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        
        var title : String
        
        if challengeList.count == 0
        {
            title = "There are no challenge available"
        }
        else
        {
            title = "Please select a challenge"
        }
        
        return title
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : NewThreadTableViewCell = newThreadTableView.dequeueReusableCell(withIdentifier: "NewThreadTableViewCell", for: indexPath) as! NewThreadTableViewCell
        
        let challengeItems = challengeList[indexPath.row]
        
        cell.nameLB.text = challengeItems.challengeName
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "newThreadDetails") {
            
            let c = segue.destination as! NewThreadViewController
            
            
            let indexPath = self.newThreadTableView.indexPathForSelectedRow
            
            if(indexPath != nil){
                
                let challenge = challengeList[indexPath!.row]
                c.challenge = challenge
                
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
