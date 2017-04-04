//
//  UserDotArtCoordinate.swift
//  NypSddpProject
//
//  Created by Qi Qi on 7/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class UserDotArtCoordinate: NSObject {

    var id : Int
    var name : String
    var lat : Double
    var long : Double
    var linkConnect : String
    var userId : Int
    var userDotArtId : Int
    var dotArtCat : Int
    var question : Int
    
    init(id : Int, name : String, lat : Double, long : Double, linkConnect : String, userId : Int, userDotArtId : Int, dotArtCat : Int, question : Int) {
        self.id = id
        self.name = name
        self.lat = lat
        self.long = long
        self.linkConnect = linkConnect
        self.userId = userId
        self.userDotArtId = userDotArtId
        self.dotArtCat = dotArtCat
        self.question = question
    }
}
