//
//  UserDotArt.swift
//  NypSddpProject
//
//  Created by Qi Qi on 6/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class UserDotArt: NSObject {

    var userDotArtId : Int
    var lat : Double
    var long : Double
    var completion : Int
    var userId : Int
    var dotArtId : Int
    var dotArtCategory : Int
    var totalScore : Double
    var isCompleted : Int
    
    init(userDotArtId : Int, lat : Double, long: Double, completion : Int, userId : Int, dotArtId : Int, dotArtCategory : Int, totalScore : Double, isCompleted : Int ) {
        
        self.userDotArtId = userDotArtId
        self.lat = lat
        self.long = long
        self.completion = completion
        self.userId = userId
        self.dotArtId = dotArtId
        self.dotArtCategory = dotArtCategory
        self.totalScore = totalScore
        self.isCompleted = isCompleted
    }
}
