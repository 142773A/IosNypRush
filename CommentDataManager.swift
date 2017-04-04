//
//  CommentDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 21/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CommentDataManager: NSObject {

    
    //retrieve all comments based on postId
    static func loadCommentsOnPostId(postId: String) -> [Comment] {
        
        let commentRows = SQLiteDB.sharedInstance.query(sql: "SELECT Comment.CommentId, Comment.Description, Comment.Date, User.Shortname Shortname, Comment.UserId CommentUserId, Comment.PostId, Profile.ProfileImg FROM Comment INNER JOIN Post ON Comment.postId = Post.PostId INNER JOIN User  on Comment.UserId = User.UserId INNER JOIN Profile ON Comment.UserId = Profile.UserId Where Comment.PostId = " + postId + "  ORDER BY Comment.Date DESC")
        
        var comments : [Comment] = []
        
        for row in commentRows
        {
            comments.append(Comment(
                id: row["CommentId"] as! Int,
                desc: row["Description"] as! String,
                date: "\(row["Date"]!)" as! String,
                userShortName: row["Shortname"] as! String,
                userId: row["CommentUserId"] as! Int,
                profileImg : row["ProfileImg"] as! String,
                postId: row["PostId"] as! Int))
        }
        return comments
    }

    
    static func loadLatestCommentId() -> [Comment]
    {
        
        let commentRows = SQLiteDB.sharedInstance.query(sql: "SELECT MAX(CommentId) CommentId from Comment")
        
        var comments : [Comment] = []
        
        for row in commentRows
        {
            comments.append(Comment(
                id: row["CommentId"] as! Int))
        }
        
        return comments
    }
    
    
    //retrieve total like comment based on CommentId
    static func loadTotalLikeCommentOnId(commentId : String) -> [Comment]
    {
        let commentRows = SQLiteDB.sharedInstance.query(sql: "SELECT a.CommentId CommentId, a.PostTitle PostTitle, a.Description CommentDescription, COUNT(a.CommentId) totalLikes FROM (SELECT * FROM Comment INNER JOIN Post ON Comment.PostId = Post.PostId) a INNER JOIN CommentUpVote ON CommentUpVote.CommentId = a.CommentId WHERE a.CommentId = " + commentId + " GROUP BY a.CommentId")
        
        var comments : [Comment] = []
        
        for row in commentRows
        {
            comments.append(Comment(
                commentId: row["CommentId"] as! Int,
                numOfLikes: row["totalLikes"] as! Int))
        }
        
        return comments
    }
    
    
    //retrieve total dislike comment based on commentId
    static func loadTotalDislikeCommentOnId(commentId : String) -> [Comment]
    {
        let commentRows = SQLiteDB.sharedInstance.query(sql: "SELECT a.CommentId CommentId, a.PostTitle PostTitle, a.Description CommentDescription, COUNT(a.CommentId) totalDislikes FROM (SELECT * FROM Comment INNER JOIN Post ON Comment.PostId = Post.PostId) a INNER JOIN CommentDownVote ON CommentDownVote.CommentId = a.CommentId WHERE a.CommentId = " + commentId + " GROUP BY a.CommentId")
        
        var comments : [Comment] = []
        
        for row in commentRows
        {
            comments.append(Comment(
                commentId: row["CommentId"] as! Int,
                numOfDislikes: row["totalDislikes"] as! Int))
        }
        
        return comments
    }

    
    //insert comment
    static func postComment(comment : Comment) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO Comment  (Description, Date, UserId, PostId) VALUES (?, ?, ?, ?)",
                 parameters: [
                    comment.commentDesc,
                    comment.commentDate,
                    comment.userId,
                    comment.postId])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }

    //retrieve commentId from current comment
    static func loadCurrentComment(desc : String, date: Double, userId : Int, postId: Int) -> [Comment]
    {
        let commentRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM Comment WHERE Description = '\(desc)' AND date = '\(date)' AND UserId = '\(userId)' AND PostId = '\(postId)'")
        
        var comments : [Comment] = []
        
        for row in commentRows
        {
            comments.append(Comment(
                id: row["CommentId"] as!Int,
                desc: row["Description"] as! String,
                currentDate: row["Date"] as! Double,
                userId: row["userId"] as! Int,
                postId: row["postId"] as! Int))
        }
        
        return comments
    }

    // delete comments when post is deleted
    static func deleteComments(comment : Comment) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM Comment WHERE PostId=?",
                parameters: [comment.postId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    
    
    
    
    // delete specific comments
    static func deleteSpecificComments(comment : Comment) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM Comment WHERE PostId=? AND CommentId=? AND UserId =?",
                parameters: [comment.postId, comment.commentId, comment.userId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    

    
    
}
