//
//  MyTeam.swift
//  NypSddpProject
//
//  Created by Foxlita on 12/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class MyTeam: NSObject {
    
    var TeamId : Int
    var TeamName : String
    var TeamDescription : String
    var TeamMember : Int
    var CompletePercent : Double
    var TeamImg : String

    
    init( TeamId  : Int, TeamName : String , TeamDescription : String, TeamMember : Int , CompletePercent : Double , TeamImg : String ) {
        self.TeamId  = TeamId
        self.TeamName =  TeamName
        self.TeamDescription = TeamDescription
        self.TeamMember = TeamMember
        self.CompletePercent = CompletePercent
        self.TeamImg = TeamImg
        
        
    }
    
    
    
    
    
    
    
}
