//
//  FriendRequest.swift
//  NypSddpProject
//
//  Created by Foxlita on 11/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class FriendRequest: NSObject {
    
    var FriendRequestId : Int
    var SenderUserId : Int
    var RecipentUserId : Int

    init( FriendRequestId  : Int, SenderUserId : Int, RecipentUserId : Int) {
        self.FriendRequestId  = FriendRequestId
        self.SenderUserId =  SenderUserId
        self.RecipentUserId = RecipentUserId

        
    }
    
    
}
