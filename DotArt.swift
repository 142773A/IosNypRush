//
//  DotArt.swift
//  NypSddpProject
//
//  Created by Qi Qi on 25/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class DotArt: NSObject {
    var dotArtId : Int
    var name: String
    var lat : Double
    var long : Double
    var question : Int
    var artTypeId : Int
    var level : Int
    
    init(id: Int, name : String, lat : Double, long : Double, question: Int, artTypeId : Int, level : Int) {
        self.dotArtId = id;
        self.name = name
        self.lat = lat
        self.long = long
        self.question = question
        self.artTypeId = artTypeId
        self.level = level
        
    }
}
