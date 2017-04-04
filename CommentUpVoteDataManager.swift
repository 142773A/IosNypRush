//
//  CommentUpVoteDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 21/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class CommentUpVoteDataManager: NSObject {
   
    
    //retrieve all like comments
    static func loadAllLikeComments() -> [CommentUpVote]
    {
        let likeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM CommentUpVote")
        
        var likes : [CommentUpVote] = []
        
        for row in likeRows
        {
            
            likes.append(CommentUpVote(
                id: row["CommentUpVoteId"] as! Int,
                userId: row["UserId"] as! Int,
                commentId: row["CommentId"] as! Int))
        }
        
        return likes
    }
    
    
    //retrieve upvote based on commentId and loginId
    static func loadUpVoteCommentId(commentId : String, userId: String) -> [CommentUpVote]
    {
        let likeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM  CommentUpVote WHERE CommentId = '" + commentId + "' AND UserId = '" + userId + "'")
        
        var likes : [CommentUpVote] = []
        
        for row in likeRows
        {
            likes.append(CommentUpVote(
                commentId: row["CommentId"] as! Int,
                userId: row["UserId"] as! Int))
        }
        
        return likes
    }
    
    
    // delete upvote comment
    static func deleteUpVoteComment(commentUpVote : CommentUpVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM CommentUpVote WHERE CommentId=? and UserId=?",
                parameters: [commentUpVote.commentId, commentUpVote.commentUpVoteUserId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    
    //insert upvote
    static func insertUpVoteComment(commentUpVote : CommentUpVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO CommentUpVote  (commentId, userId) VALUES (?, ?)",
                 parameters: [
                    commentUpVote.commentId,
                    commentUpVote.commentUpVoteUserId])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }

}
