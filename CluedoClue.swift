//
//  CluedoClue.swift
//  NypSddpProject
//
//  Created by Leon Tan on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CluedoClue: NSObject {
    var clueId : Int!
    var clueDescription : String!
    var clueImage : String!
    var lat : Double!
    var lng : Double!
    var score : Int!
    
    
    init(id: Int, clueDescription: String, imagePath: String , lat : Double, lng : Double, score : Int) {
        self.clueId = id
        self.clueDescription = clueDescription
        self.clueImage = imagePath
        self.lat = lat
        self.lng = lng
        self.score = score
    }
    
}
