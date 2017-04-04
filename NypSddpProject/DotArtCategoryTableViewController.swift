//
//  DotArtCategoryTableViewController.swift
//  NypSddpProject
//
//  Created by Qi Qi on 26/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class DotArtCategoryTableViewController: UITableViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var artCategoryTableView: UITableView!
    // Declare an array of artType objects
    var artTypeList : [ArtType] = []
    var challangeArtTypeList : [ChallengeArt] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Loads up the list of artType from the database
        artTypeList = DotArtDataManager.loadArtCategory()
        challangeArtTypeList = DotArtDataManager.loadArtChallengeByCategoryName(categoryName: "Art")
        
        for item in challangeArtTypeList{
            if(item.challengeSegment == "challenge_art_dot_art"){
                descriptionLabel.text = item.challengeDescription
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var catName = ""
      
        if(indexPath.row >= 0){
            let cat = artTypeList[indexPath.row]
            catName = cat.artTypeName
            print(cat)
        }
        switch catName {
            
        case "Shape":
            self.performSegue(withIdentifier: "ShowDotArtDetails", sender: self)
            //self.present(c, animated:true, completion:nil)
        default:
            let alert = UIAlertController(title: "Oops!", message: "This is currently locked", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDotArtDetails"){
            let c = segue.destination as! DotArtCategoryDetailViewController
            let indexPath = self.artCategoryTableView.indexPathForSelectedRow
            
            if(indexPath != nil){
                let cat = artTypeList[indexPath!.row]
                print(cat)
                c.artCategory = cat
                
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    /*override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return 0
     } */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artTypeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : DotArtCategoryTableViewCell = artCategoryTableView.dequeueReusableCell (withIdentifier: "DotArtCategoryTableViewCell", for: indexPath)
            as! DotArtCategoryTableViewCell
        
        let p = artTypeList[indexPath.row]
        cell.artCategoryLabel.text = p.artTypeName
        cell.artCategoryImageView.image = UIImage(named: p.artTypeImage)
        
        return cell
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
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
