//
//  PostCategoryTableViewCell.swift
//  NypSddpProject
//
//  Created by iOS on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryIcon: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}
