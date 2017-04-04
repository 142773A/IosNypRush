//
//  RequestTableViewCell.swift
//  NypSddpProject
//
//  Created by Foxlita on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var schImage: UIImageView!
    @IBOutlet weak var acceptBtn: UIButton!
    

    override func awakeFromNib() {
        
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
