//
//  ThreadDetailsTableViewCell.swift
//  NypSddpProject
//
//  Created by ℜ . on 17/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ThreadDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentUserIcon: UIImageView!
    @IBOutlet weak var commentUsername: UILabel!
 
    @IBOutlet weak var commentDesc: UITextView!
    
    @IBOutlet weak var commentDate: UILabel!
    
    @IBOutlet weak var commentLikeButton: UIButton!
    @IBOutlet weak var commentLikeCount: UILabel!
    
    @IBOutlet weak var commentDislikeButton: UIButton!
    @IBOutlet weak var commentDislikeCount: UILabel!
    
    
    @IBOutlet weak var deleteButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
