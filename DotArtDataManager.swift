//
//  DotArtDataManager.swift
//  NypSddpProject
//
//  Created by Qi Qi on 26/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class DotArtDataManager: NSObject {

    
    
    //retrieve
    // Loads the list of art category from the database
    // and convert it into a [ArtType] array
    //
    static func loadArtCategory() -> [ArtType]
    {
        let artTypeRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM ArtType ORDER BY ArtTypeName ASC")
        
        var artType : [ArtType] = []
        for row in artTypeRows
        {
            artType.append(ArtType(
                id: row["ArtTypeId"] as! Int,
                name: row["ArtTypeName"] as! String,
                imagePath: row["ArtTypeImage"] as! String))
        }
        return artType;
    }
    
    //load all the challange under art category
    
    static func loadArtChallengeByCategoryName(categoryName : String) -> [ChallengeArt]
    {
        let challengesRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM Challenge  c INNER JOIN ChallengeCategory cc ON cc.ChallengeCategoryId = c.CategoryId WHERE cc.ChallengeCategoryType = '"+categoryName+"'")
        
        var challengeArtList : [ChallengeArt] = []
        
        for row in challengesRow {
            challengeArtList.append(ChallengeArt(
                id: row["ChallengeId"] as! Int,
                categoryId: row["CategoryId"] as! Int,
                name: row["ChallengeName"] as! String,
                description: row["ChallengeDescription"] as! String,
                segment: row["ChallengeSegment"] as! String,
                categoryType: row["ChallengeCategoryType"] as! String))
        }
        
        return challengeArtList
    }
    
    //load the challenge by level, qnsmm artType category from dot art table
    
    static func loadDotArtChallenge(level : String, question : String, artTypeId : String) -> [DotArt]
    {
        let dotArtRow = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM DotArt WHERE Level = '"+level+"' AND Question = '"+question+"' AND ArtTypeId = '"+artTypeId+"'")
        
        var dotArtList : [DotArt] = []
        
        for row in dotArtRow {
            dotArtList.append(DotArt(id: row["DotArtId"] as! Int, name: row["Name"] as! String, lat: row["Lat"] as! Double, long: row["Long"] as! Double, question: row["Question"] as! Int, artTypeId: row["ArtTypeId"] as! Int, level: row["Level"] as! Int))
        }
        
        return dotArtList
    }
    
    static func loadDotArtChallengeById(dotId : String) -> [DotArt]
    {
        let dotArtRow = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM DotArt WHERE DotArtId = '"+dotId+"'")
        
        var dotArtList : [DotArt] = []
        
        for row in dotArtRow {
            dotArtList.append(DotArt(id: row["DotArtId"] as! Int, name: row["Name"] as! String, lat: row["Lat"] as! Double, long: row["Long"] as! Double, question: row["Question"] as! Int, artTypeId: row["ArtTypeId"] as! Int, level: row["Level"] as! Int))
        }
        
        return dotArtList
    }
  
}
