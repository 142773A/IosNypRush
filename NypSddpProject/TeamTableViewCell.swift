//
//  TeamTableViewCell.swift
//  NypSddpProject
//
//  Created by Foxlita on 25/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class TeamTableViewCell: UITableViewCell {
    
    
    

    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var memberScore: UILabel!
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
