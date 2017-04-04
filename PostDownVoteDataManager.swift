//
//  PostDownVoteDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 16/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostDownVoteDataManager: NSObject {

    //retrieve all dislikepost
    static func loadAllDislikePost() -> [PostDownVote]
    {
        let dislikeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM PostDownVote")
        
        var dislikes : [PostDownVote] = []
        
        for row in dislikeRows
        {
            dislikes.append(PostDownVote(
                id: row["PostDownVoteId"] as! Int,
                userId: row["UserId"] as! Int,
                postId: row["PostId"] as! Int))
        }
        
        return dislikes
    }
    
    
    //retrieve downvote based on postId
    static func loadDownVotePostId(postId : String, userId : String) -> [PostDownVote]
    {
        let dislikeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM  PostDownVote WHERE postId = '" + postId + "' AND UserId = '" + userId + "'")
        
        var dislikes : [PostDownVote] = []
        
        for row in dislikeRows
        {
            dislikes.append(PostDownVote(
                postId: row["PostId"] as! Int,
                userId: row["UserId"] as! Int))
        }
        
        return dislikes
    }
    
    // delete downvote post
    static func deleteDownVotePost(postDownVote : PostDownVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM PostDownVote WHERE PostId=? and UserId=?",
                parameters: [postDownVote.postId, postDownVote.downVoteUserId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    
    //insert downvote
    static func insertDownVote(postDownVote : PostDownVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO PostDownVote  (postId, userId) VALUES (?, ?)",
                    parameters: [
                    postDownVote.postId,
                    postDownVote.downVoteUserId] )
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }

}
