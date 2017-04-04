//
//  PhotoArtDataManager.swift
//  NypSddpProject
//
//  Created by Qi Qi on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PhotoArtDataManager: NSObject {
    
    //retrieve all the segments
    static func loadPhotoArtSegments() -> [PhotoArtSegment]
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM PhotoArtSegment")
        
        var photoArtSegmentList : [PhotoArtSegment] = []
        
        for row in list {
            photoArtSegmentList.append(PhotoArtSegment(
                segmentId: row["PhotoArtSegmentId"] as! Int,
                segmentName: row["Name"] as! String,
                totalCubes: row["TotalCubes"] as! Int))
        }
        
        return photoArtSegmentList
    }
    
    //retrieve segment based on the Id
    static func loadPhotoArtSegmentsById(segmentId : Int) -> PhotoArtSegment
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM PhotoArtSegment WHERE PhotoArtSegmentId='"+"\(segmentId)"+"'")
        
        var photoArtSegmentList : PhotoArtSegment? = nil
        
        for row in list {
            photoArtSegmentList = PhotoArtSegment(
                segmentId: row["PhotoArtSegmentId"] as! Int,
                segmentName: row["Name"] as! String,
                totalCubes: row["TotalCubes"] as! Int)
        }
        
        return photoArtSegmentList!
    }
    
    
    //retrieve question by the segments
    static func loadPhotoArtBySegmentId(segmentId : Int) -> [PhotoArt]
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM PhotoArt WHERE PhotoArtSegmentId='"+"\(segmentId)"+"'")
        
        var photoArtList : [PhotoArt] = []
        
        for row in list {
            photoArtList.append(PhotoArt(
                id: row["PhotoArtId"] as! Int,
                segmentId: row["PhotoArtSegmentId"] as! Int,
                colNo: row["ColNo"] as! Int,
                rowNo: row["RowNo"] as! Int,
                question : row ["Question"] as! String,
                questionType : row ["QuestionType"] as! String,
                photoArtValidateId: row["PhotoArtValidateId"] as! Int))
        }
        
        return photoArtList
    }
    
    //retrieve the validtor by photo art id
    
    static func loadPhotoArtValidateByPhotoArtId(photoArtId : Int) -> [PhotoArtValidate]
    {
        let list = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM PhotoArtValidate WHERE PhotoArtId= '"+"\(photoArtId)"+"'")
        
        var photoArtValidateList : [PhotoArtValidate] = []
        
        for row in list {
            photoArtValidateList.append(PhotoArtValidate(id: row["PhotoArtValidateId"] as! Int,
                                                         person: row["Person"] as! Int,
                                                         gender: row["Gender"] as! String,
                                                         object: row["Object"] as! String,
                                                         age: row["Age"] as! String,
                                                         emotion: row["Emotion"] as! String,
                                                         word: row["Word"] as! String,
                                                         photoArtID: row["PhotoArtId"] as! Int))
        }
        
        return photoArtValidateList
    }
}
