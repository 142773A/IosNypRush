	//
//  PostUpVoteDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 16/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostUpVoteDataManager: NSObject {

    //retrieve all likepost
    static func loadAllLikePost() -> [PostUpVote]
    {
        let likeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM PostUpVote")
        
        var likes : [PostUpVote] = []
        
        for row in likeRows
        {
            
            likes.append(PostUpVote(
                id: row["PostUpVoteId"] as! Int,
                userId: row["UserId"] as! Int,
                postId: row["PostId"] as! Int))
        }
        
        return likes
    }
    
    
    //retrieve upvote based on postId and loginId
    static func loadUpVotePostId(postId : String, userId: String) -> [PostUpVote]
    {
        let likeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM  PostUpVote WHERE PostId = '" + postId + "' AND UserId = '" + userId + "'")
        
        var likes : [PostUpVote] = []
        
        for row in likeRows
        {
            likes.append(PostUpVote(
                postId: row["PostId"] as! Int,
                userId: row["UserId"] as! Int))
        }
        
        return likes
    }
    
    
    // delete upvote post
    static func deleteUpVotePost(postUpVote : PostUpVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM PostUpVote WHERE PostId=? and UserId=?",
                parameters: [postUpVote.postId, postUpVote.upVoteUserId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    
    //insert upvote
    static func insertUpVote(postUpVote : PostUpVote) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO PostUpVote  (postId, userId) VALUES (?, ?)",
                    parameters: [
                    postUpVote.postId,
                    postUpVote.upVoteUserId])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
    
    

}
