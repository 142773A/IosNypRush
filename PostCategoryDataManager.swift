//
//  PostCategoryDataManager.swift
//  NypSddpProject
//
//  Created by ℜ . on 16/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostCategoryDataManager: NSObject {

    
    //retrieve all category
    static func loadChallengeCategory() -> [PostCategory]
    {
        let categoryTypeRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM ChallengeCategory ORDER BY ChallengeCategoryType ASC")
        
        var categoryType : [PostCategory] = []
        for row in categoryTypeRows
        {
            categoryType.append(PostCategory(
                id: row["ChallengeCategoryId"] as! Int,
                category: row["ChallengeCategoryType"] as! String))
        }
        
        return categoryType;
    }

}
