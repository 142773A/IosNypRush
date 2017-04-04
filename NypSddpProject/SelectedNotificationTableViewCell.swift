//
//  SelectedNotificationTableViewCell.swift
//  NypSddpProject
//
//  Created by iOS on 25/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class SelectedNotificationTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLB: UILabel!
    
    @IBOutlet weak var descriptionLB: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
