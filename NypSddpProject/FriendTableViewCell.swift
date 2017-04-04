//
//  FriendTableViewCell.swift
//  NypSddpProject
//
//  Created by Foxlita on 28/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    @IBOutlet weak var friendScore: UILabel!
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
