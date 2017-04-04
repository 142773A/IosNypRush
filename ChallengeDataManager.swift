//
//  ChallengeDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class ChallengeDataManager: NSObject {

    //retrieve challenge
    static func loadChallenge(categoryId : String) -> [Challenge]
    {
        let challengeRows = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM Challenge WHERE CategoryId = '" + categoryId + "' ORDER BY ChallengeName ASC")
        
        var challenges : [Challenge] = []
        
        for row in challengeRows
        {
            challenges.append(Challenge(
                challengeId: row["ChallengeId"] as! Int,
                categoryId: row["CategoryId"] as! Int,
                challengeName: row["ChallengeName"] as! String,
                challengeDesc: row["ChallengeDescription"] as! String))
        }
        
        return challenges
    }
    
    static func loadChallengeName(categoryId : String) -> [Challenge]
    {
        let challengeRows = SQLiteDB.sharedInstance.query(sql: "SELECT ChallengeName FROM Challenge WHERE CategoryId = '" + categoryId + "' GROUP by ChallengeName ORDER BY ChallengeName ASC")
        
        var challenges : [Challenge] = []
        
        for row in challengeRows
        {
            challenges.append(Challenge(
                challengeName: row["ChallengeName"] as! String))
        }
        
        return challenges

    }

}
