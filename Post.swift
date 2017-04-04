//
//  Post.swift
//  NypSddpProject
//
//  Created by iOS on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Post: NSObject {

    var postId : Int!
    var postTitle : String!
    var postDesc : String!
    var postDate : Double!
    var convertedPostDate : String!
    var postImage : String!
    var postName : String!
    var postUsername : String!
    var postShortname : String!
    var challengeName : String!
    var challengeCategoryType : String!
    var userId : Int!
    var challengeId: Int!
    var profileImg: String!
    
    //for counting of likes/dislikes
    var numOfLikes: Int!
    var numOfDislikes: Int!
    
    //insert post
    init (postTitle: String, postDesc: String, postImage: String, postDate: Double, userId: Int, challengeId: Int)
    {
        self.postTitle = postTitle
        self.postDesc = postDesc
        self.postImage = postImage
        self.postDate = postDate
        self.userId = userId
        self.challengeId = challengeId
    }
    
    //retrive all post
    init (id: Int, title: String, description desc: String, date: String, userId : Int, challengeId: Int)
    {
        
        self.postId = id
        self.postTitle = title
        self.postDesc = desc
        self.convertedPostDate = date
        self.userId = userId
        self.challengeId = challengeId
        super.init()
    }
    
     // retrieve all post based on category or postId
    init (id: Int, title: String, description desc: String, date: String, userId: Int, name: String, username: String, shortname: String, challengeName: String, image: String, profileImg: String, category: String)
    {
        
        self.postId = id
        self.postTitle = title
        self.postDesc = desc
        self.convertedPostDate = date
        self.userId = userId
        self.postName = name
        self.postUsername = username
        self.postShortname = shortname
        self.challengeName = challengeName
        self.postImage = image
        self.profileImg = profileImg
        self.challengeCategoryType = category
        super.init()
    }
    
    
    //retrieve all like post based on category
    init (id: Int, title: String, category: String, likeCount: Int)
    {
        self.postId = id
        self.postTitle = title
        self.challengeCategoryType = category
        self.numOfLikes = likeCount
    }
    
    
    //retrieve all dislike post based on category
    init (id: Int, title: String, category: String, dislikeCount: Int)
    {
        self.postId = id
        self.postTitle = title
        self.challengeCategoryType = category
        self.numOfDislikes = dislikeCount
    }
    
    
    
    //retrieve all like post based on postID
    init (id: Int, likeCount: Int)
    {
        self.postId = id
        self.numOfLikes = likeCount
    }
    
    
    //retrieve all dislike post based on postId
    init (id: Int, dislikeCount: Int)
    {
        self.postId = id
        self.numOfDislikes = dislikeCount
    }
    
    //delete post 
    init (id: Int, userId: Int)
    {
        self.postId = id
        self.userId = userId
    }
    
    
}
