//
//  SuggestTableViewCell.swift
//  NypSddpProject
//
//  Created by Foxlita on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class SuggestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var schLabel: UILabel!
    @IBOutlet weak var schImage: UIImageView!
    @IBOutlet weak var requestBtn: UIButton!
    
    
    
    

    override func awakeFromNib() {
        

        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    @IBAction func requestClick(_ sender: AnyObject) {

        
    requestBtn.setTitle("Pending", for: .normal)
    requestBtn.setTitleColor(UIColor .red, for: UIControlState.normal)
    requestBtn.isUserInteractionEnabled = false
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
