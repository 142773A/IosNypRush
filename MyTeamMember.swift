//
//  MyTeamMember.swift
//  NypSddpProject
//
//  Created by Foxlita on 25/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class MyTeamMember: NSObject {
    
    var TeamMemberId : Int
    var UserId : Int
    var TeamId : Int
    
    init( TeamMemberId : Int, UserId : Int, TeamId : Int ) {
        self.TeamMemberId = TeamMemberId
        self.UserId =  UserId
        self.TeamId = TeamId
        
        
        
    }
    
    
}
