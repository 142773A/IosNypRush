//
//  CluedoAnswer.swift
//  NypSddpProject
//
//  Created by Leon Tan on 29/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CluedoAnswer: NSObject {
    var clueAnswerId : Int!
    var clueAnswerDescription : String!
    var clueAnswerImage : String!
    var clueAnswerLat : Double!
    var clueAnswerLng : Double!
    var clueAnswerScore : Int!
    
    
    init(id: Int, clueDescription: String, imagePath: String , lat : Double, lng : Double, score : Int) {
        self.clueAnswerId = id
        self.clueAnswerDescription = clueDescription
        self.clueAnswerImage = imagePath
        self.clueAnswerLat = lat
        self.clueAnswerLng = lng
        self.clueAnswerScore = score
    }
}
