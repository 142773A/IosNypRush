//
//  ArtType.swift
//  NypSddpProject
//
//  Created by Qi Qi on 26/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class ArtType: NSObject {
    var artTypeId : Int!
    var artTypeName : String!
    var artTypeImage : String!
    
    init(id: Int, name: String, imagePath: String) {
        self.artTypeId = id
        self.artTypeName = name
        self.artTypeImage = imagePath
    }
    
}
