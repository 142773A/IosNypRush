//
//  Friend.swift
//  NypSddpProject
//
//  Created by Foxlita on 11/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Friend: NSObject {
    
    var FriendId : Int
    var SenderUserId : Int
    var RecipentUserId : Int

   
    init( FriendId  : Int, SenderUserId : Int, RecipentUserId : Int) {
        self.FriendId  = FriendId
        self.SenderUserId =  SenderUserId
        self.RecipentUserId = RecipentUserId

    }
    
    
}
