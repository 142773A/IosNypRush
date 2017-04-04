//
//  ChallengeTableViewController.swift
//  NypSddpProject
//
//  Created by iOS on 24/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

@available(iOS 10.0, *)
class ChallengeTableViewController: UITableViewController {

    @IBOutlet weak var completeLabel: UILabel!
    
    
    var challengeList : [UserDotArt] = []
    var artTypeList : ArtType?
 

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      let userId = UserDefaults.standard.integer(forKey: "userId")
       challengeList = ProfileChallengeDataManager.loadChallengeByUserId(id: "\(userId)")
      
        for item in challengeList{
            completeLabel.text = String(item.isCompleted)
       }
        
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
            let cell: ChallengeTableViewCell = a as! ChallengeTableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return challengeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let cell : ChallengeTableViewCell = tableView.dequeueReusableCell (withIdentifier: "ChallengeTableViewCell", for: indexPath)
            as! ChallengeTableViewCell
        
        let p = challengeList[indexPath.row]
        
        
        cell.scoreLabel.text = String(p.totalScore)
        
        let yourChallenge = String(p.dotArtId)
        
        let tempDotArt = DotArtDataManager.loadDotArtChallengeById(dotId: yourChallenge)
        artTypeList = ProfileChallengeDataManager.loadArtTypeByArtTypeId(artTypeId: "\(tempDotArt[0].artTypeId)")
        
        cell.nameLabel.text = artTypeList?.artTypeName

        cell.imageLabel.image = UIImage(named:(artTypeList?.artTypeImage)!)
        
        
        
        
        
    
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



    
}
