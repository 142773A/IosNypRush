//
//  PostUpVote.swift
//  NypSddpProject
//
//  Created by iOS on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostUpVote: NSObject {
    
    var upVoteId : Int!
    var upVoteUserId : Int!
    var postId: Int!
    
    //retrieve upvote post based on postId and userId
    init (id: Int, userId : Int, postId: Int)
    {
        self.upVoteId = id
        self.upVoteUserId = userId
        self.postId = postId
        super.init()
    }
    
    //insert up vote post based on postId and userId
    init (postId: Int, userId: Int)
    {
        self.postId = postId
        self.upVoteUserId = userId
    }
    
    
    
    
}
