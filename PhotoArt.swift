//
//  PhotoArt.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PhotoArt: NSObject {
    
    var photoArtId : Int
    var segmentId : Int
    var colNo : Int
    var rowNo : Int
    var question : String
    var questionType : String
    var photoArtValidateId : Int
    
    init(id : Int, segmentId : Int, colNo : Int, rowNo : Int, question : String, questionType : String, photoArtValidateId : Int) {
        self.photoArtId = id
        self.segmentId = segmentId
        self.colNo = colNo
        self.rowNo = rowNo
        self.question = question
        self.questionType = questionType
        self.photoArtValidateId = photoArtValidateId
    }
}
