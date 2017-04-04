//
//  CommentUpVote.swift
//  NypSddpProject
//
//  Created by iOS on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CommentUpVote: NSObject {
    
    var commentUpVoteId : Int!
    var commentUpVoteUserId : Int!
    var commentId : Int!
    
    init (id: Int, userId : Int, commentId: Int)
    {
        self.commentUpVoteId = id
        self.commentUpVoteUserId = userId
        self.commentId = commentId
        super.init()
    }

    init (commentId: Int, userId : Int)
    {
        self.commentId = commentId
        self.commentUpVoteUserId = userId
        super.init()
    }

}
