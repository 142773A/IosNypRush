//
//  TeamDataManager.swift
//  NypSddpProject
//
//  Created by Foxlita on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class TeamDataManager: NSObject {
    
    //retrieve
    // Loads the list of Team from the database
    // and convert it into a [TeamType] array
    //
    
    
    static func loadTeamByTeamId(teamId : String) -> MyTeam
    {
        let teamRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM Team WHERE TeamId= '"+teamId+"'")
        
        var myteam : MyTeam? = nil
        
        for row in teamRow{
            
            myteam = MyTeam(
                TeamId: row["TeamId"] as! Int,
                TeamName: row["TeamName"] as! String,
                TeamDescription: row["TeamDescription"] as! String,
                TeamMember: row["TeamMember"] as! Int,
                CompletePercent: row["CompletePercent"] as! Double,
                TeamImg: row["TeamImg"] as! String
            )
        }
        return myteam!;
    }
    
    
    
    static func loadTeamMemberByTeamId(teamId : String) -> [MyTeamMember]
    {
        let teamRow = SQLiteDB.sharedInstance.query(sql:"SELECT * FROM TeamMember WHERE TeamId= '"+teamId+"'")
        
        var teammember : [MyTeamMember] = []
        
        for row in teamRow{
            
           teammember.append(MyTeamMember(
                TeamMemberId: row["TeamMemberId"] as! Int,
                UserId: row["UserId"] as! Int,
                TeamId: row["TeamId"] as! Int
                )
            )
        }
        return teammember;
    }


    static func loadUserDotArtScore(userId : String ) -> UserDotArt
    {
        let userRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM UserDotArt WHERE UserId= '"+userId+"'")
        
        var users : UserDotArt? = nil
        for row in userRows
        {
            users =  UserDotArt ( userDotArtId: row["UserDotArtId"] as! Int,
                                    lat: row["Lat"] as! Double,
                                    long: row["Long"] as! Double,
                                    completion: row["CompletionRate"] as! Int,
                                    userId: row["UserId"] as! Int,
                                    dotArtId: row["DotArtId"] as! Int,
                                    dotArtCategory: row["DotArtCategory"] as! Int,
                                    totalScore: row["TotalScore"] as! Double,
                                    isCompleted:row["IsCompletedCategory"] as! Int)
        }
        return users!;
    }
    
    
    
    static func loadUserByUserId(userId : String ) -> User
    {
        let userRow = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM User WHERE UserId= '"+userId+"'")
        
        var user : User? = nil
        
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

    
    
    
    
    
    
    
    
    
    
    
    
}
