//
//  ProfileDaraManager.swift
//  NypSddpProject
//
//  Created by iOS on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ProfileDataManager: NSObject {
    
    //retrieve
    // retrieve selected profile by username (unique)
    
    static func loadProfileByUserId(id:String) -> Profile
    {
        let profileRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM Profile WHERE UserId= '"+id+"'")
        
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
    
    
    
    
    
    static func loadSchoolBySchoolId(schoolId : String) -> School
    {
        let schoolRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM School WHERE SchoolId = '"+schoolId+"'")
        
        var school : School? = nil
        
        for row in schoolRow{
            
            school = School(SchoolId: row["SchoolId"] as! Int,
                              SchoolName: row["SchoolName"] as! String,
                              SchoolShortName: row["SchoolShortName"] as! String
                       
            )
            
        }
        
        return school!;
    }


    
    
    
    
    
    
    
    
    
    
    
    
    
}
