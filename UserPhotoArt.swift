
//
//  UserPhotoArt.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class UserPhotoArt: NSObject {
    var userPhotoArtId : Int
    var segmentId : Int
    var colNo : Int
    var rowNo : Int
    var completionRate :Int
    var userId : Int
    var photoArtId : Int
    var totalScore : Double
    var isCompletedCategory : Int //how many time complete for this segment
    
    
    init(id :Int, segmentId : Int, colNo : Int, rowNo : Int, completionRate : Int, userId: Int, photoArtId : Int, totalScore : Double, completed : Int) {
        self.userPhotoArtId = id
        self.segmentId = segmentId
        self.colNo = colNo
        self.rowNo = rowNo
        self.completionRate = completionRate
        self.userId = userId
        self.photoArtId = photoArtId
        self.totalScore = totalScore
        self.isCompletedCategory = completed
    }
}
