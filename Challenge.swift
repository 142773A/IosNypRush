
//
//  Challenge.swift
//  NypSddpProject
//
//  Created by ℜ . on 30/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Challenge: NSObject {
    
    var challengeId : Int!
    var categoryId: Int!
    var challengeName: String!
    var challengeDesc : String!
    
    //load all challenge
    init(challengeId: Int, categoryId: Int, challengeName: String, challengeDesc: String)
    {
        self.challengeId = challengeId
        self.categoryId = categoryId
        self.challengeName = challengeName
        self.challengeDesc = challengeDesc
    }
    

    //load challengeName
    init(challengeName: String)
    {
        self.challengeName = challengeName
    }
}
