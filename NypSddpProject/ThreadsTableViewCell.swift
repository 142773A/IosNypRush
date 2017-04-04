//
//  ThreadsTableViewCell.swift
//  NypSddpProject
//
//  Created by ℜ . on 15/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ThreadsTableViewCell: UITableViewCell {

    @IBOutlet weak var threadImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
   
    @IBOutlet weak var challengeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var dislikeCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
