//
//  DotArtUserDataManager.swift
//  NypSddpProject
//
//  Created by iOS on 6/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class DotArtUserDataManager: NSObject {

    // retrieve all dot art user records
    static func loadDotArtUser() -> [UserDotArt]
    {
        let userRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserDotArt")
        
        var users : [UserDotArt] = []
        for row in userRows
        {
            users.append(UserDotArt(userDotArtId: row["UserDotArtId"] as! Int,
                                    lat: row["Lat"] as! Double,
                                    long: row["Long"] as! Double,
                                    completion: row["CompletionRate"] as! Int,
                                    userId: row["UserId"] as! Int,
                                    dotArtId: row["DotArtId"] as! Int,
                                    dotArtCategory: row["DotArtCategory"] as! Int,
                                    totalScore: row["TotalScore"] as! Double,
                                    isCompleted:row["IsCompletedCategory"] as! Int))
        }
        return users;
    }

    
    
    // retrieve selected user record
    static func loadDotArtUserByUserId(userId : String, dotArtCat : String) -> Any?
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserDotArt WHERE UserId='"+userId+"'AND DotArtCategory='"+dotArtCat+"'")
        
        var user : UserDotArt? = nil
        
        for row in userRow{
            
            user = UserDotArt(userDotArtId: row["UserDotArtId"] as! Int,
                              lat: row["Lat"] as! Double,
                              long: row["Long"] as! Double,
                              completion: row["CompletionRate"] as! Int,
                              userId: row["UserId"] as! Int,
                              dotArtId: row["DotArtId"] as! Int,
                              dotArtCategory: row["DotArtCategory"] as! Int,
                              totalScore: row["TotalScore"] as! Double,
                              isCompleted:row["IsCompletedCategory"] as! Int)
        }
        
        if( user != nil){
            return user!;
        }
        else{
            return nil
        }
    }
    
    //insert a new record for user first time they participate a new dot art category 
    static func insertNewRecord(userDotArt : UserDotArt) -> Bool
    {
        do {
         let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT OR REPLACE INTO UserDotArt (UserDotArtId, " + "Lat, Long, CompletionRate, UserId, DotArtId, DotArtCategory, TotalScore, IsCompletedCategory) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                                          parameters: [
                                                            userDotArt.userDotArtId,
                                                            userDotArt.lat,
                                                            userDotArt.long,
                                                            userDotArt.completion,
                                                            userDotArt.userId,
                                                            userDotArt.dotArtId,
                                                            userDotArt.dotArtCategory,
                                                            userDotArt.totalScore,
                                                            userDotArt.isCompleted] )
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
    
    
    
    // Update the user current progress
    static func updateUserCurrentProgress(userDotArt : UserDotArt) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"UPDATE UserDotArt SET Lat=?, Long=?, CompletionRate=?, DotArtId=? WHERE UserDotArtId=?",
                parameters: [userDotArt.lat, userDotArt.long, userDotArt.completion, userDotArt.dotArtId, userDotArt.userDotArtId])
            
            return true
        }
        catch {
            print("Update failed")
            return false
        }
    }
    
    //User Dot Art Coordinate
    
    // retrieve all dot art user Coordinate records
    static func loadUserDotArtCoordinate() -> [UserDotArtCoordinate]
    {
        let userRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserDotArtCoordinate")
        
        var usersCoordinates : [UserDotArtCoordinate] = []
        for row in userRows
        {
            usersCoordinates.append(UserDotArtCoordinate(
                id: row["UserDotArtCoordinateId"] as! Int,
                name: row["Name"] as! String,
                lat: row["Lat"] as! Double,
                long: row["Long"] as! Double,
                linkConnect: row["LinkConnect"] as! String,
                userId: row["UserId"] as! Int,
                userDotArtId: row["UserDotArtId"] as! Int,
                dotArtCat: row["DotArtCategory"] as! Int,
                question: row["Question"] as! Int))
        }
        return usersCoordinates;
    }
    
    // retrieve selected user coordinate record
    static func loadUserDotArtCoordinateByUserId(userId : String, userDotArt : String) ->[UserDotArtCoordinate]
    {
        let userRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserDotArtCoordinate WHERE UserId= '"+userId+"'AND UserDotArtId = '"+userDotArt+"'")
        
        var usersCoordinates : [UserDotArtCoordinate] = []
        
        for row in userRows
        {
            usersCoordinates.append(UserDotArtCoordinate(
                id: row["UserDotArtCoordinateId"] as! Int,
                name: row["Name"] as! String,
                lat: row["Lat"] as! Double,
                long: row["Long"] as! Double,
                linkConnect: row["LinkConnect"] as! String,
                userId: row["UserId"] as! Int,
                userDotArtId: row["UserDotArtId"] as! Int,
                dotArtCat: row["DotArtCategory"] as! Int,
                question: row["Question"] as! Int))
        }
        return usersCoordinates;
    }
    
    //insert coordinate in User Dot Art Coordinate
    static func insertNewCoordinate(userDotArtCoordinate : UserDotArtCoordinate) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT OR REPLACE INTO UserDotArtCoordinate (UserDotArtCoordinateId, " + "Name, Lat, Long, LinkConnect, UserId, UserDotArtId, DotArtCategory, Question) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",parameters: [
                    userDotArtCoordinate.id,
                    userDotArtCoordinate.name,
                    userDotArtCoordinate.lat,
                    userDotArtCoordinate.long,
                    userDotArtCoordinate.linkConnect,
                    userDotArtCoordinate.userId,
                    userDotArtCoordinate.userDotArtId,
                    userDotArtCoordinate.dotArtCat,
                    userDotArtCoordinate.question] )
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
    
    // Update the user coordinate current progress
    static func updateUserCoordinateLink(link : String, id : Int) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"UPDATE UserDotArtCoordinate SET LinkConnect=? WHERE UserDotArtCoordinateId=?",
                parameters: [link, id])
            
            return true
        }
        catch {
            print("Update failed")
            return false
        }
    }
    
    //delete all the user current progress as successfully ended all the category
    
    static func deleteUserCoordinateAfterDone(userId : Int, userDotId : Int, dotArtCategory : Int) -> Bool
    {
        do{
            SQLiteDB.sharedInstance.execute(sql: "DELETE FROM UserDotArtCoordinate WHERE UserId = ? AND UserDotArtId = ? AND DotArtCategory = ?", parameters: [userId, userDotId, dotArtCategory])
            
            return true
        }catch{
            print("Delete failed")
            return false
        }
        
    }
}
