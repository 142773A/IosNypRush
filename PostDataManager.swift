//
//  ForumDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostDataManager: NSObject {
    
   

    // retrieve all post based on category
    static func loadPostOnCategory(categoryId: String) -> [Post]
    {
        let postRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT PostId, PostTitle, Description, Date,  User.UserId, Name, Username, Shortname, ChallengeName, Profile.ProfileImg, Post.Image, ChallengeCategoryType  FROM Post INNER JOIN Challenge ON Challenge.ChallengeId = Post.ChallengeId INNER JOIN ChallengeCategory ON ChallengeCategory.ChallengeCategoryId = Challenge.CategoryId  INNER JOIN User ON User.UserId = Post.UserId  INNER JOIN Profile ON User.UserId = Profile.UserId WHERE ChallengeCategory.ChallengeCategoryId = '" + categoryId + "'")
        
        var posts : [Post] = []
        for row in postRows
        {
            posts.append(Post(id: row["PostId"] as! Int,
                              title: row["PostTitle"] as! String,
                              description: row["Description"] as! String,
                              date: "\(row["Date"]!)" as! String,
                              userId: row["UserId"] as! Int,
                              name: row["Name"] as! String,
                              username:row["Username"] as! String,
                              shortname: row["Shortname"] as! String,
                              challengeName: row["ChallengeName"] as! String,
                              image: row["Image"] as! String,
                              profileImg: row["ProfileImg"] as! String,
                              category: row["ChallengeCategoryType"] as! String))
        }
        return posts;
    }
    
    
    // retrieve all post based on category and challenge name
    static func loadPostOnCategoryAndChallengeName(categoryId: String, challengeName: String) -> [Post]
    {
        let postRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT PostId, PostTitle, Description, Date, User.UserId, Name, Username, Shortname, ChallengeName, Image, ProfileImg, ChallengeCategoryType FROM Post INNER JOIN Challenge ON Challenge.ChallengeId = Post.ChallengeId INNER JOIN ChallengeCategory ON ChallengeCategory.ChallengeCategoryId = Challenge.CategoryId INNER JOIN User ON User.UserId = Post.UserId INNER JOIN Profile ON User.UserId = Profile.UserId WHERE ChallengeCategory.ChallengeCategoryId = '" + categoryId + "' AND Challenge.ChallengeName = '" + challengeName + "'")
        
        var posts : [Post] = []
        for row in postRows
        {
            posts.append(Post(id: row["PostId"] as! Int,
                              title: row["PostTitle"] as! String,
                              description: row["Description"] as! String,
                              date: "\(row["Date"]!)" as! String,
                              userId: row["UserId"] as! Int,
                              name: row["Name"] as! String,
                              username:row["Username"] as! String,
                              shortname: row["Shortname"] as! String,
                              challengeName: row["ChallengeName"] as! String,
                              image: row["Image"] as! String,
                              profileImg: row["ProfileImg"] as! String,
                              category: row["ChallengeCategoryType"] as! String))
        }
        return posts;
    }
    
    //load post on postId
    static func loadPostOnPostId(postId : String) -> Post
    {
        let postRows = SQLiteDB.sharedInstance.query(sql:
        "SELECT PostId, PostTitle, Description, Date, User.UserId, Name, Username, Shortname, ChallengeName, Image, ProfileImg, ChallengeCategoryType FROM Post INNER JOIN Challenge ON Challenge.ChallengeId = Post.ChallengeId INNER JOIN ChallengeCategory ON ChallengeCategory.ChallengeCategoryId = Challenge.CategoryId INNER JOIN User ON User.UserId = Post.UserId INNER JOIN Profile ON User.UserId = Profile.UserId WHERE Post.PostId = '" + postId + "'")
    
        var posts : Post! = nil
        
        for row in postRows
        {
            posts = (Post(id: row["PostId"] as! Int,
                              title: row["PostTitle"] as! String,
                              description: row["Description"] as! String,
                              date: "\(row["Date"]!)" as! String,
                              userId: row["UserId"] as! Int,
                              name: row["Name"] as! String,
                              username:row["Username"] as! String,
                              shortname: row["Shortname"] as! String,
                              challengeName: row["ChallengeName"] as! String,
                              image: row["Image"] as! String,
                              profileImg: row["ProfileImg"] as! String,
                              category: row["ChallengeCategoryType"] as! String))
        }
        return posts!;
    }
    
    //retrieve all like post based on category
    static func loadPostLikeOnCategory(categoryId: String) -> [Post] {
        
        let postRows = SQLiteDB.sharedInstance.query(sql: "SELECT a.PostId PostId, a.PostTitle PostTitle ,a.CategoryId CategoryId , a.ChallengeCategoryType ChallengeCategoryType ,COUNT(a.PostId) totalLikes FROM (SELECT * FROM Post INNER JOIN Challenge ON Post.ChallengeId = Challenge.ChallengeId INNER JOIN ChallengeCategory ON ChallengeCategory.ChallengeCategoryId = Challenge.CategoryId) a INNER JOIN PostUpVote ON PostUpVote.PostId = a.PostId WHERE a.CategoryId = '" + categoryId + "' GROUP BY a.PostId")
        
        var posts : [Post] = []
        
        for row in postRows
        {
         posts.append(Post(id: row["PostId"] as! Int,
                           title: row["PostTitle"] as! String ,
                           category: row["ChallengeCategoryType"] as! String,
                           likeCount: row["totalLikes"] as! Int))
        }
        return posts
    }
    
    
    //retrieve all dislike post based on category
    static func loadPostDislikeOnCategory(categoryId: String) -> [Post] {
    
        
        let postRows = SQLiteDB.sharedInstance.query(sql: "SELECT a.PostId PostId, a.PostTitle PostTitle ,a.CategoryId CategoryId , a.ChallengeCategoryType ChallengeCategoryType ,COUNT(a.PostId) totalDislikes FROM (SELECT * FROM Post INNER JOIN Challenge ON Post.ChallengeId = Challenge.ChallengeId INNER JOIN ChallengeCategory ON ChallengeCategory.ChallengeCategoryId = Challenge.CategoryId) a INNER JOIN PostDownVote ON PostDownVote.PostId = a.PostId WHERE a.CategoryId = '" + categoryId + "' GROUP BY a.PostId")
        
        var posts : [Post] = []
        
        for row in postRows
        {
            posts.append(Post(id: row["PostId"] as! Int,
                              title: row["PostTitle"] as! String ,
                              category: row["ChallengeCategoryType"] as! String,
                              dislikeCount: row["totalDislikes"] as! Int))
        }
        return posts
    }
    
    
    //retrieve total like post based on PostId
    static func loadTotalLikePostOnId(postId : String) -> [Post]
    {
        let postRows = SQLiteDB.sharedInstance.query(sql: "SELECT Post.PostId, COUNT(PostUpVote.PostId) totalLikes FROM Post INNER JOIN PostUpVote ON PostUpVote.PostId = Post.PostId WHERE Post.PostId = "  + postId + " GROUP BY Post.PostId")
        
        var posts : [Post] = []
        
        for row in postRows
        {
            posts.append(Post(
                id: row["PostId"]  as! Int,
                likeCount: row["totalLikes"] as! Int))
        }
        
        return posts
    }
    
    
    //retrieve total dislike post based on PostId
    static func loadTotalDislikePostOnId(postId : String) -> [Post]
    {
        let postRows = SQLiteDB.sharedInstance.query(sql: "SELECT Post.PostId, COUNT(PostDownVote.PostId) totalDislikes FROM Post INNER JOIN PostDownVote ON PostDownVote.PostId = Post.PostId WHERE Post.PostId = "  + postId + " GROUP BY Post.PostId")
        
        var posts : [Post] = []
        
        for row in postRows
        {
            posts.append(Post(
                id: row["PostId"]  as! Int,
                dislikeCount: row["totalDislikes"] as! Int))
        }
        
        return posts
    }
    
    //insert post
    static func insertPost(post : Post) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO Post  (PostTitle, Description, Image, Date, UserId, ChallengeId) VALUES (?, ?, ?, ?, ?, ?)",
                    parameters: [post.postTitle, post.postDesc, post.postImage, post.postDate, post.userId, post.challengeId])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }

    // delete post
    static func deletePost(post : Post) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM Post WHERE PostId=? and UserId=?",
                parameters: [post.postId, post.userId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    

    

}
