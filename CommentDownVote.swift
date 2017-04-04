//
//  CommentDownVote.swift
//  NypSddpProject
//
//  Created by iOS on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CommentDownVote: NSObject {
    
    var commentDownVoteId : Int!
    var commentDownVoteUserId : Int!
    var commentId : Int!
    
    init (id: Int, userId : Int, commentId: Int)
    {
        self.commentDownVoteId = id
        self.commentDownVoteUserId = userId
        self.commentId = commentId
        super.init()
    }

    init (commentId: Int, userId : Int)
    {
        self.commentId = commentId
        self.commentDownVoteUserId = userId
        super.init()
    }
}
