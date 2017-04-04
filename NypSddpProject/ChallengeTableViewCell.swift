//
//  ChallengeTableViewCell.swift
//  NypSddpProject
//
//  Created by iOS on 24/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    

    override func awakeFromNib() {
        
        
        
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
