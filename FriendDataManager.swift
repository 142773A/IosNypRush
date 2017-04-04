//
//  File.swift
//  NypSddpProject
//
//  Created by Foxlita on 11/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class FriendDataManager: NSObject {
    
    //retrieve
    // Loads the list of friends from the database
    // and convert it into a [FriendType] array
    //
    
    
    static func loadAllFriendBySenderIdMe(id : String) -> [User]    {
        let friendRow = SQLiteDB.sharedInstance.query(sql:" SELECT User.UserId, User.Name, User.Shortname, User.Username,  User.Password, User.RoleId, User.Year, FriendId, SenderUserId, RecipentUserId, Profile.ProfileImg FROM User INNER JOIN Friend ON User.UserId  = Friend.RecipentUserId INNER JOIN Profile ON User.UserId = Profile.UserId  WHERE SenderUserId = " + id)
        
        var friendType : [User] = []
        
        for row in friendRow{
            
            friendType.append(User(userId: row["UserId"] as! Int,
                                   name: row["Name"] as! String,
                                   shortname: row["Shortname"] as! String,
                                   username: row["Username"] as! String,
                                   password: row["Password"] as! String,
                                   roleId: row["RoleId"] as! Int,
                                   year: row["Year"] as! Int,
                                   SenderUserId: row["SenderUserId"] as! Int,
                                   RecipentUserId: row["RecipentUserId"] as! Int,
                                   FriendId: row["FriendId"] as! Int,
                                   ProfileImg: row["ProfileImg"] as! String))
        }
        return friendType;
    }
    
    
    static func loadAllFriendBySearchResult(searchName : String) -> User   {
        let userRow = SQLiteDB.sharedInstance.query(
            sql:"SELECT User.UserId, User.Name, User.Shortname, User.Username,User.Password, User.RoleId, User.Year, Friend.FriendId, Friend.RecipentUserId, Friend.SenderUserId, Profile.ProfileImg FROM User INNER JOIN Friend ON User.UserId = Friend.RecipentUserId INNER JOIN Profile ON User.UserId = Profile.UserId WHERE User.Name LIKE '%" + searchName + "%'")
        
        var userType : User! = nil
        
        for row in userRow{
            
            userType = User(userId: row["UserId"] as! Int,
                            name: row["Name"] as! String,
                            shortname: row["Shortname"] as! String,
                            username: row["Username"] as! String,
                            password: row["Password"] as! String,
                            roleId: row["RoleId"] as! Int,
                            year: row["Year"] as! Int,
                            SenderUserId: row["SenderUserId"] as! Int,
                            RecipentUserId: row["RecipentUserId"] as! Int,
                            FriendId: row["FriendId"] as! Int,
                            ProfileImg: row["ProfileImg"] as! String)
            
        }
        return userType;
    }
    
    
    
    
    static func loadAllRequestBySearchResult(searchName : String) -> User   {
        let userRow = SQLiteDB.sharedInstance.query(
            sql:"SELECT User.UserId, User.Name, User.Shortname, User.Username,User.Password, User.RoleId, User.Year, SuggestFriend.SuggestId, SuggestFriend.SenderUserId, Profile.ProfileImg FROM User INNER JOIN SuggestFriend ON User.UserId = SuggestFriend.SenderUserId INNER JOIN Profile ON User.UserId = Profile.UserId WHERE User.Name LIKE '%" + searchName + "%'")
        
        var userType : User! = nil
        
        for row in userRow{
            
            userType = User(userId: row["UserId"] as! Int,
                            name: row["Name"] as! String,
                            shortname: row["Shortname"] as! String,
                            username: row["Username"] as! String,
                            password: row["Password"] as! String,
                            roleId: row["RoleId"] as! Int,
                            year: row["Year"] as! Int,
                            SenderUserId: row["SenderUserId"] as! Int,
                            SuggestId: row["SuggestId"] as! Int,
                            ProfileImg: row["ProfileImg"] as! String)
            
        }
        return userType;
    }
    
    
    

    
    static func loadAllFriend() -> [Friend]    {
        let friendRow = SQLiteDB.sharedInstance.query(sql:" SELECT * FROM Friend" )
        
        var friendType : [Friend] = []
        
        for row in friendRow{
            
            friendType.append(Friend (
                FriendId: row["FriendId"] as! Int,
                SenderUserId: row["SenderUserId"] as! Int,
                RecipentUserId: row["RecipentUserId"] as! Int))
        }
        return friendType;
    }
    
    
    static func loadAllFriendRequest() -> [FriendRequest]    {
        let friendRow = SQLiteDB.sharedInstance.query(sql:" SELECT * FROM FriendRequest" )
        
        var friendType : [FriendRequest] = []
        
        for row in friendRow{
            
            friendType.append(FriendRequest (
                FriendRequestId: row["FriendRequestId"] as! Int,
                SenderUserId: row["SenderUserId"] as! Int,
                RecipentUserId: row["RecipentUserId"] as! Int))
        }
        return friendType;
    }

    
    static func DeleteSelectFriend(friendId : String) {
        let friendRow = SQLiteDB.sharedInstance.execute(sql:" DELETE FROM Friend WHERE FriendId = '" + friendId + "'" )
        
   
    }
    
    static func DeleteSuggestFriend(suggestId : String) {
        let friendSuggestRow = SQLiteDB.sharedInstance.execute(sql:" DELETE FROM SuggestFriend WHERE SuggestId = '" + suggestId + "'" )
        
        
    }
    
    
    static func DeleteSelectRequest(friendRequestId : String) {
        let friendRequestRow = SQLiteDB.sharedInstance.execute(sql:" DELETE FROM FriendRequest WHERE FriendRequestId = '" + friendRequestId + "'" )
        
    }
    
    
    
    static func loadUserByUserId(userId : String) -> User
    {
        let userRow = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM User WHERE UserId = '" + userId + "'")
        
        var user : User! = nil
        
        for row in userRow{
            
            user = User(userId: row["UserId"] as! Int,
                        name: row["Name"] as! String,
                        shortname: row["Shortname"] as! String,
                        username: row["Username"] as! String,
                        password: row["Password"] as! String,
                        roleId: row["RoleId"] as! Int,
                        year: row["Year"] as! Int)
        }
        return user!;
    }
    
    
    static func insertNewFriendRecord(Friend : Friend) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO Friend (FriendId , SenderUserId , RecipentUserId) " + "VALUES (?, ?, ?)",
                                                         parameters: [
                                                            Friend.FriendId,
                                                            Friend.SenderUserId,
                                                            Friend.RecipentUserId] )
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
    

    static func insertNewFriendRequestRecord(FriendRequest : FriendRequest) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO FriendRequest (FriendRequestId , SenderUserId , RecipentUserId) " + "VALUES (?, ?, ?)",
                                                         parameters: [
                                                            FriendRequest.FriendRequestId,
                                                            FriendRequest.SenderUserId,
                                                            FriendRequest.RecipentUserId] )
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }

   

    static func loadFriendRequestByRecipentIdMe(id : String) -> [FriendRequest]    {
        let friendrequestRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM FriendRequest WHERE RecipentUserId = '" + id + "'")
        
        var friendrequestType : [FriendRequest] = []
        
        for row in friendrequestRow{
            
          friendrequestType.append(FriendRequest(
                FriendRequestId: row["FriendRequestId"] as! Int,
                SenderUserId: row["SenderUserId"] as! Int,
                RecipentUserId: row["RecipentUserId"] as! Int))
            
        }
        return friendrequestType;
    }

    
    static func loadFriendRequestByFriendRequestId(friendRequestId : String) -> [FriendRequest]    {
        let friendrequestRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM FriendRequest WHERE FriendRequestId = '" + friendRequestId + "'")
        
        var friendrequestType : [FriendRequest] = []
        
        for row in friendrequestRow{
            
            friendrequestType.append(FriendRequest(
                FriendRequestId: row["FriendRequestId"] as! Int,
                SenderUserId: row["SenderUserId"] as! Int,
                RecipentUserId: row["RecipentUserId"] as! Int))
            
        }
        return friendrequestType;
    }
    
    
    static func loadSuggestFriendBySuggestId(friendSuggestId : String) -> [SuggestFriend]    {
        let friendrequestRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM SuggestFriend WHERE SuggestId = '" + friendSuggestId + "'")
        
        var friendrequestType : [SuggestFriend] = []
        
        for row in friendrequestRow{
            
            friendrequestType.append(SuggestFriend(
                SuggestId: row["SuggestId"] as! Int,
                SenderUserId: row["SenderUserId"] as! Int))
            
        }
        return friendrequestType;
    }
 
    
    static func loadAllSuggestFriend() -> [SuggestFriend]    {
        let suggestRow = SQLiteDB.sharedInstance.query(sql:" SELECT * FROM SuggestFriend ")
        
        var suggestType : [SuggestFriend] = []
        
        for row in suggestRow{
            
            suggestType.append(SuggestFriend(
                SuggestId: row["SuggestId"] as! Int,
                SenderUserId: row["SenderUserId"] as! Int ))
            
        }
        return suggestType;
    }
    
    
    
    
    
    static func loadProfileByUserId(userId : String ) -> Profile
    {
        let profileRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM Profile WHERE UserId= '"+userId+"'")
        
        var profile : Profile? = nil
        
        for row in profileRow{
            
            profile = Profile(ProfileId: row["ProfileId"] as! Int,
                              SchoolId: row["SchoolId"] as! Int,
                              MyChallenge: row["MyChallenge"] as! Int,
                              UserId: row["UserId"] as! Int,
                              ScoreId: row["ScoreId"] as! Int,
                              Likes: row["Likes"] as! Int,
                              Friends: row["Friends"] as! Int,
                              Posts: row["Posts"] as! Int,
                              TeamId: row["TeamId"] as! Int,
                              imagePath: row["ProfileImg"] as! String
            )
            
        }
        
        return profile!;
    }

    

    
    static func AcceptSelectFriend(SendersId : String)   {
        let friendrequestRow = SQLiteDB.sharedInstance.execute(sql:" INSERT INTO Friend(SenderUserId,RecipentUserId) VALUES(SendersId,loginId)" )
        
    }
    
    
    static func AcceptSuggestFriend(SendersId : String)   {
        let friendsuggestRow = SQLiteDB.sharedInstance.execute(sql:" INSERT INTO Friend(SenderUserId,RecipentUserId) VALUES(SendersId,loginId)" )
        
    }
    
    
    static func RequestSuggestFriend(SendersId : String)   {
        let requestsuggestRow = SQLiteDB.sharedInstance.execute(sql:" INSERT INTO FriendRequest(SenderUserId,RecipentUserId) VALUES(loginId,SendersId)" )
        
    }
    
    
}


