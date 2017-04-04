//
//  CommentDownVoteDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 21/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CommentDownVoteDataManager: NSObject {

    
    //retrieve all dislike comments
    static func loadAllDislikeComments() -> [CommentDownVote]
    {
        let dislikeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM CommentDownVote")
        
        var dislikes : [CommentDownVote] = []
        
        for row in dislikeRows
        {
            
            dislikes.append(CommentDownVote(
                id: row["CommentDownVoteId"] as! Int,
                userId: row["UserId"] as! Int,
                commentId: row["CommentId"] as! Int))
        }
        
        return dislikes
    }
    
    
    
    //retrieve downvote based on commentId
    static func loadDownVoteCommentId(commentId : String, userId : String) -> [CommentDownVote]
    {
        let dislikeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM  CommentDownVote WHERE commentId = '" + commentId + "' AND UserId = '" + userId + "'")
        
        var dislikes : [CommentDownVote] = []
        
        for row in dislikeRows
        {
            dislikes.append(CommentDownVote(
                commentId: row["CommentId"] as! Int,
                userId: row["UserId"] as! Int))
        }
        
        return dislikes
    }
    
    // delete downvote comment
    static func deleteDownVoteComment(commentDownVote : CommentDownVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM CommentDownVote WHERE CommentId=? and UserId=?",
                parameters: [commentDownVote.commentId, commentDownVote.commentDownVoteUserId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    
    //insert downvote
    static func insertDownVoteComment(commentDownVote : CommentDownVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO CommentDownVote  (commentId, userId) VALUES (?, ?)",
                  parameters: [
                          commentDownVote.commentId,
                          commentDownVote.commentDownVoteUserId])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
}
