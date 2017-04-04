//
//  Comment.swift
//  NypSddpProject
//
//  Created by iOS on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Comment: NSObject {
    
    var commentId : Int!
    var commentDesc : String!
    var commentDate : Double!
    var convertedCommentDate: String!
    var userShortName : String!
    var userId: Int!
    var postId : Int!
    var profileImg : String!
    
    
    //for counting of likes/dislikes
    var numOfLikes: Int!
    var numOfDislikes: Int!
    
    //retrieve all comments based on postId
    init (id: Int, desc : String, date: String, userId: Int, postId: Int)
    {
        self.commentId = id
        self.commentDesc = desc
        self.convertedCommentDate = date
        self.userId = userId
        self.postId = postId
        super.init()
    }
    
    
    //retrieve current commented comments
    init (id: Int, desc : String, currentDate: Double, userId: Int, postId: Int)
    {
        self.commentId = id
        self.commentDesc = desc
        self.commentDate = currentDate
        self.userId = userId
        self.postId = postId
        super.init()
    }
    
    //retrieve comment on postId
    init (id: Int, desc : String, date: String, userShortName: String, userId: Int, profileImg : String, postId: Int)
    {
        self.commentId = id
        self.commentDesc = desc
        self.convertedCommentDate = date
        self.userShortName = userShortName
        self.userId = userId
        self.profileImg = profileImg
        self.postId = postId
        super.init()
    }
    
    //post comment 
    init (desc : String, date: Double, userId: Int, postId: Int)
    {
        self.commentDesc = desc
        self.commentDate = date
        self.userId = userId
        self.postId = postId
        super.init()
    }
    
    //retrieve latestCommentId
    init (id: Int)
    {
        self.commentId = id
    }
    
    //retrieve totalLikes on commentId
    init (commentId: Int, numOfLikes: Int)
    {
        self.commentId = commentId
        self.numOfLikes = numOfLikes
        super.init()
    }
    
    //retrieve totalDislikes on commentId
    init (commentId: Int, numOfDislikes: Int)
    {
        self.commentId = commentId
        self.numOfDislikes = numOfDislikes
        super.init()
    }
    
    //delete comments if post is deleted
    init (postId: Int)
    {
        self.postId = postId
    }
    
    
    //delete specific comments
    init (postId: Int, commentId: Int, userId: Int)
    {
        self.postId = postId
        self.commentId = commentId
        self.userId = userId
    }
}
