//
//  PhotoArtUserDataManager.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PhotoArtUserDataManager: NSObject {

    //retrieve all the users participated in photo art
    static func loadPhotoArtUsers() -> [UserPhotoArt]
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserPhotoArt")
        
        var photoArtUserList : [UserPhotoArt] = []
        
        for row in list {
            photoArtUserList.append(UserPhotoArt(id: row["UserPhotoArtId"] as! Int,
                                                 segmentId: row["PhotoArtSegmentId"] as! Int,
                                                 colNo: row["ColNo"] as! Int,
                                                 rowNo: row["RowNo"] as! Int,
                                                 completionRate: row["CompletionRate"] as! Int,
                                                 userId: row["UserId"] as! Int,
                                                 photoArtId: row["PhotoArtId"] as! Int,
                                                 totalScore: row["TotalScore"] as! Double,
                                                 completed: row["IsCompletedCategory"] as! Int))
        }
        
        return photoArtUserList
    }
    
    //retrieve user based on user id
    static func loadPhotoArtUserByUserId(userId : String) -> Any?
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserPhotoArt WHERE UserId= '"+userId+"'")
        
        var user : UserPhotoArt? = nil
        
        for row in userRow{
            
            user = UserPhotoArt(id: row["UserPhotoArtId"] as! Int,
                                segmentId: row["PhotoArtSegmentId"] as! Int,
                                colNo: row["ColNo"] as! Int,
                                rowNo: row["RowNo"] as! Int,
                                completionRate: row["CompletionRate"] as! Int,
                                userId: row["UserId"] as! Int,
                                photoArtId: row["PhotoArtId"] as! Int,
                                totalScore: row["TotalScore"] as! Double,
                                completed: row["IsCompletedCategory"] as! Int)
        }
        
        if( user != nil){
            return user!;
        }
        else{
            return nil
        }
    }
    
    //retrieve user based on user photo art id
    static func loadPhotoArtUserByUserPhotoArtId(userPhotoArtId : String) -> Any?
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserPhotoArt WHERE UserPhotoArtId= '"+userPhotoArtId+"'")
        
        var user : UserPhotoArt? = nil
        
        for row in userRow{
            
            user = UserPhotoArt(id: row["UserPhotoArtId"] as! Int,
                                segmentId: row["PhotoArtSegmentId"] as! Int,
                                colNo: row["ColNo"] as! Int,
                                rowNo: row["RowNo"] as! Int,
                                completionRate: row["CompletionRate"] as! Int,
                                userId: row["UserId"] as! Int,
                                photoArtId: row["PhotoArtId"] as! Int,
                                totalScore: row["TotalScore"] as! Double,
                                completed: row["IsCompletedCategory"] as! Int)
        }
        
        if( user != nil){
            return user!;
        }
        else{
            return nil
        }
    }
    
    //insert a new record for user first time they participate photo art
    static func insertNewRecord(userPhotoArt : UserPhotoArt) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT OR REPLACE INTO UserPhotoArt (UserPhotoArtId, " + "PhotoArtSegmentId, ColNo, RowNo, CompletionRate, UserId, PhotoArtId, TotalScore, IsCompletedCategory) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                                         parameters: [
                                                            userPhotoArt.userPhotoArtId,
                                                            userPhotoArt.segmentId,
                                                            userPhotoArt.colNo,
                                                            userPhotoArt.rowNo,
                                                            userPhotoArt.completionRate,
                                                            userPhotoArt.userId,
                                                            userPhotoArt.photoArtId,
                                                            userPhotoArt.totalScore,
                                                            userPhotoArt.isCompletedCategory])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }

    
    //insert a new record for user art progress
    static func insertNewRecordProgress(userPhotoArtPrgoress : UserPhotoArtProgress) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT OR REPLACE INTO UserPhotoArtProgress (UserPhotoArtProgressId, " + "ColNo, RowNo, ImageUrl, UserId, UserPhotoArtId, PhotoArtSegmentId, Description, Tag, Status) " + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                                         parameters: [
                                                            userPhotoArtPrgoress.userPhotoArtProgressId,
                                                            userPhotoArtPrgoress.colNo,
                                                            userPhotoArtPrgoress.rowNo,
                                                            userPhotoArtPrgoress.imageUrl,
                                                            userPhotoArtPrgoress.userId,
                                                            userPhotoArtPrgoress.userPhotoArtId,
                                                            userPhotoArtPrgoress.segmentId,
                                                            userPhotoArtPrgoress.descriptionGenerated,
                                                            userPhotoArtPrgoress.tags,
                                                            userPhotoArtPrgoress.status])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
    
    static func loadAllPhotoArtUsersProgress() -> [UserPhotoArtProgress]
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserPhotoArtProgress")
        
        var photoArtUserProgressList : [UserPhotoArtProgress] = []
        
        for row in list {
            photoArtUserProgressList.append(UserPhotoArtProgress(id: row["UserPhotoArtProgressId"] as! Int,
                                                                 colNo: row["ColNo"] as! Int,
                                                                 rowNo: row["RowNo"] as! Int,
                                                                 imageUrl: row["ImageUrl"] as! String,
                                                                 userId: row["UserId"] as! Int,
                                                                 userPhotoArtId: row["UserPhotoArtId"] as! Int,
                                                                 segmentId: row["PhotoArtSegmentId"] as! Int,
                                                                 descriptionGenerated: row["Description"] as! String,
                                                                 tags: row["Tag"] as! String,
                                                                 status: row["Status"] as! Int))
        }
        
        return photoArtUserProgressList
    }
    
    //retrieve user based on user id and user segment, col and row
    static func loadPhotoArtUserProgressByUserIdSegmentColRow(userId : String, segmentId : String, colNo : String, rowNo : String) -> Any?
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserPhotoArtProgress WHERE UserId= '"+userId+"' AND PhotoArtSegmentId = '"+segmentId+"' AND ColNo = '"+colNo+"' AND RowNo ='"+rowNo+"'")
        
        var user : UserPhotoArtProgress? = nil
        
        for row in userRow{
            
            user = UserPhotoArtProgress(id: row["UserPhotoArtProgressId"] as! Int,
                                        colNo: row["ColNo"] as! Int,
                                        rowNo: row["RowNo"] as! Int,
                                        imageUrl: row["ImageUrl"] as! String,
                                        userId: row["UserId"] as! Int,
                                        userPhotoArtId: row["UserPhotoArtId"] as! Int,
                                        segmentId: row["PhotoArtSegmentId"] as! Int,
                                        descriptionGenerated: row["Description"] as! String,
                                        tags: row["Tag"] as! String,
                                        status: row["Status"] as! Int)
        }
        
        if( user != nil){
            return user!;
        }
        else{
            return nil
        }
    }
    //load by user id
    static func loadPhotoArtUsersProgressByUserId(userId : String) -> [UserPhotoArtProgress]
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM UserPhotoArtProgress WHERE UserId= '"+userId+"'")
        
        var photoArtUserProgressList : [UserPhotoArtProgress] = []
        
        for row in list {
            photoArtUserProgressList.append(UserPhotoArtProgress(id: row["UserPhotoArtProgressId"] as! Int,
                                                                 colNo: row["ColNo"] as! Int,
                                                                 rowNo: row["RowNo"] as! Int,
                                                                 imageUrl: row["ImageUrl"] as! String,
                                                                 userId: row["UserId"] as! Int,
                                                                 userPhotoArtId: row["UserPhotoArtId"] as! Int,
                                                                 segmentId: row["PhotoArtSegmentId"] as! Int,
                                                                 descriptionGenerated: row["Description"] as! String,
                                                                 tags: row["Tag"] as! String,
                                                                 status: row["Status"] as! Int))
        }
        
        return photoArtUserProgressList
    }

}
