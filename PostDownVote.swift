//
//  PostDownVote.swift
//  NypSddpProject
//
//  Created by iOS on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostDownVote: NSObject {

    var downVoteId : Int!
    var downVoteUserId : Int!
    var postId: Int!
    
    //retrieve down post vote based on userId and PostId
    init (id: Int, userId : Int, postId: Int)
    {
        self.downVoteId = id
        self.downVoteUserId = userId
        self.postId = postId
        super.init()
    }

    //insert down post vote based on userId and postId
    init (postId: Int, userId: Int)
    {
        self.postId = postId
        self.downVoteUserId = userId
    }
    
}
