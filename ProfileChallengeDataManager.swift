//
//  ProfileChallengeDataManager.swift
//  NypSddpProject
//
//  Created by iOS on 3/2/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ProfileChallengeDataManager: NSObject {

    static func loadChallengeByUserId(id:String) -> [UserDotArt]
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM UserDotArt WHERE UserId= '"+id+"'")
        
        var userChallenge : [UserDotArt] = []
        
        for row in userRow{
            
            userChallenge.append( UserDotArt(
                userDotArtId: row["UserDotArtId"] as! Int,
                lat: row["Lat"] as! Double,
                long: row["Long"] as! Double,
                completion: row["CompletionRate"] as! Int,
                userId: row["UserId"] as! Int,
                dotArtId: row["DotArtId"] as! Int,
                dotArtCategory: row["DotArtCategory"] as! Int,
                totalScore: row["TotalScore"] as! Double,
                isCompleted:row["IsCompletedCategory"] as! Int
                )
            )
        }
        return userChallenge;
    }
    
    
    
    static func loadArtTypeByArtTypeId(artTypeId : String ) -> ArtType
    {
        let dotartRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM ArtType WHERE ArtTypeId= '"+artTypeId+"'")
        
        var dotChallenge : ArtType? = nil
        
        for row in dotartRow{
            
            dotChallenge = ArtType(
                id: row["ArtTypeId"] as! Int,
                name: row["ArtTypeName"] as! String,
                imagePath: row["ArtTypeImage"] as! String
                
                
            )
        }
        return dotChallenge!;
    }
    

    
}
