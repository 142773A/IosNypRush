//
//  TeamTableViewController.swift
//  NypSddpProject
//
//  Created by Foxlita on 26/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit


class TeamTableViewController: UITableViewController {
    
    @IBOutlet weak var teamDescriptionLabel: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamScoreLabel: UILabel!
    @IBOutlet weak var qrCode: UIImageView!

    var membersList : [MyTeamMember] = []
    var teamList : [MyTeam] = []
    var teamMember : User?
    var teamScore : UserDotArt?
    var teamImg : Profile?
   

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let userId = UserDefaults.standard.integer(forKey: "userId")
        let tempProfile = TeamDataManager.loadProfileByUserId(userId: "\(userId)")
        teamList = [TeamDataManager.loadTeamByTeamId(teamId: "\(tempProfile.TeamId)")]
        membersList = TeamDataManager.loadTeamMemberByTeamId(teamId: "\(tempProfile.TeamId)")
       
      
        
 
        
        for item in teamList{
            teamNameLabel.text = String(item.TeamName)
             teamDescriptionLabel.text = item.TeamDescription
            let image: UIImage = UIImage(named:(item.TeamImg))!
            teamLogo.image = image
            teamLogo.layer.borderWidth = 8.0
            teamLogo.layer.masksToBounds = false
            teamLogo.layer.borderColor = UIColor(white: 0.7, alpha: 0.9).cgColor
            teamLogo.layer.cornerRadius = teamLogo.frame.size.width/2
            teamLogo.clipsToBounds = true
        }
        
        tableView.reloadData()
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
            let cell: TeamTableViewCell = a as! TeamTableViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
    }
    
    
    
    
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return membersList.count
        
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell : TeamTableViewCell = tableView.dequeueReusableCell (withIdentifier: "TeamTableViewCell", for: indexPath)
            as! TeamTableViewCell
        
        let p = membersList[indexPath.row]
        //cell.memberName.text = String(p.UserId)
    
        let memberId = String(p.UserId)
        
        teamMember = TeamDataManager.loadUserByUserId(userId: memberId)
        teamScore = TeamDataManager.loadUserDotArtScore(userId: memberId)
        teamImg = TeamDataManager.loadProfileByUserId(userId: memberId)
        
        cell.memberName.text = teamMember?.name
        cell.memberScore.text = String(format:"%.1f",(teamScore?.totalScore)!)
        cell.imageLabel.image = UIImage(named:(teamImg?.ProfileImg)!)
        teamScoreLabel.text = String(format:"%.1f",(teamScore?.totalScore)!)
        
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
