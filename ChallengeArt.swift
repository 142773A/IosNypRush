//
//  ChallengeArt.swift
//  NypSddpProject
//
//  Created by Qi Qi on 27/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

import UIKit

class ChallengeArt: NSObject {

    var challegeId : Int!
    var challengeCategoryId : Int!
    var challengeName : String!
    var challengeDescription: String!
    var challengeSegment: String!
    var challengeCategoryType : String!
    
    init(id : Int, categoryId : Int, name: String, description : String, segment: String, categoryType : String) {
        
        self.challegeId = id;
        self.challengeCategoryId = categoryId
        self.challengeName = name
        self.challengeDescription = description
        self.challengeSegment = segment
        self.challengeCategoryType = categoryType
        
    }
}
