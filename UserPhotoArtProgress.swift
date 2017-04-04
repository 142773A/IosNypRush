//
//  UserPhotoArtProgress.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class UserPhotoArtProgress: NSObject {
    var userPhotoArtProgressId : Int
    var colNo : Int
    var rowNo : Int
    var imageUrl : String
    var userId : Int
    var userPhotoArtId : Int
    var segmentId : Int
    var descriptionGenerated: String
    var tags : String
    var status : Int
    
    init(id: Int, colNo : Int, rowNo : Int, imageUrl :String, userId: Int, userPhotoArtId : Int, segmentId : Int, descriptionGenerated : String, tags : String, status : Int) {
        self.userPhotoArtProgressId = id
        self.colNo = colNo
        self.rowNo = rowNo
        self.imageUrl = imageUrl
        self.userId = userId
        self.userPhotoArtId = userPhotoArtId
        self.segmentId = segmentId
        self.descriptionGenerated = descriptionGenerated
        self.tags = tags
        self.status = status
    }
}
