//
//  Profile.swift
//  NypSddpProject
//
//  Created by iOS on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Profile: NSObject {
    
    var ProfileId : Int
    var SchoolId : Int
    var MyChallenge : Int
    var UserId : Int
    var ScoreId : Int
    var Likes : Int
    var Friends : Int
    var Posts : Int
    var TeamId : Int
    var ProfileImg : String!
    
    init( ProfileId : Int, SchoolId : Int, MyChallenge : Int, UserId : Int , ScoreId : Int, Likes : Int , Friends : Int ,Posts : Int , TeamId : Int , imagePath: String) {
        self.ProfileId = ProfileId
        self.SchoolId =  SchoolId
        self.MyChallenge = MyChallenge
        self.UserId = UserId
        self.ScoreId = ScoreId
        self.Likes  = Likes
        self.Friends = Friends
        self.Posts  = Posts
        self.TeamId  = TeamId
        self.ProfileImg  = imagePath

    
    }
    
    
}
