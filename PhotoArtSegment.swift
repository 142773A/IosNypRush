//
//  PhotoArtSegment.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PhotoArtSegment: NSObject {
    
    var photoArtSegmentId : Int
    var name: String
    var totalCubes: Int
    
    init(segmentId: Int, segmentName : String, totalCubes: Int) {
        self.photoArtSegmentId = segmentId
        self.name = segmentName
        self.totalCubes = totalCubes
    }
}
