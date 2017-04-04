//
//  NotificationCategoryTableViewCell.swift
//  NypSddpProject

//  Created by iOS on 24/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class NotificationCategoryTableViewCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    
    @IBOutlet weak var badgeBorder: BadgeSwift!
    
    @IBOutlet weak var badgeNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
