//
//  DotArtCategoryTableViewCell.swift
//  NypSddpProject
//
//  Created by Qi Qi on 26/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class DotArtCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var artCategoryImageView: UIImageView!
    
    @IBOutlet weak var artCategoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
