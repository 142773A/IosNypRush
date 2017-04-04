//
//  User.swift
//  NypSddpProject
//
//  Created by QiQi on 6/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var userId : Int
    var name : String
    var shortname : String
    var username : String
    var password : String
    var roleId : Int
    var year : Int
    
    var SenderUserId : Int!
    var FriendId : Int!
    var RecipentUserId : Int!
    var ProfileImg : String!
    var SuggestId : Int!
    
    init( userId : Int, name : String, shortname : String, username : String, password : String, roleId : Int, year : Int) {
        self.userId = userId
        self.name =  name
        self.shortname = shortname
        self.username = username
        self.password = password
        self.roleId = roleId
        self.year = year
    }
    

    init( userId : Int, name : String, shortname : String, username : String, password : String, roleId : Int, year : Int, SenderUserId : Int , RecipentUserId : Int , FriendId : Int , ProfileImg : String ) {
        self.userId = userId
        self.name =  name
        self.shortname = shortname
        self.username = username
        self.password = password
        self.roleId = roleId
        self.year = year
        self.SenderUserId = SenderUserId
        self.RecipentUserId = RecipentUserId
        self.FriendId = FriendId
        self.ProfileImg = ProfileImg
        
    }
    
    
    init( userId : Int, name : String, shortname : String, username : String, password : String, roleId : Int, year : Int, SenderUserId : Int , SuggestId : Int ,ProfileImg : String ) {
        self.userId = userId
        self.name =  name
        self.shortname = shortname
        self.username = username
        self.password = password
        self.roleId = roleId
        self.year = year
        self.SenderUserId = SenderUserId
        self.SuggestId = SuggestId
        self.ProfileImg = ProfileImg
        
    }
    
    
    
    
    
    
    
    
}
