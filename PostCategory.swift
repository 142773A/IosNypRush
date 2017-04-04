//
//  PostCategory.swift
//  NypSddpProject
//
//  Created by iOS on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PostCategory: NSObject {

    var postCategoryId : Int!
    var postCategoryType : String!
    
    
    
    //retrive all category
    init (id: Int, category: String)
    {
        self.postCategoryId = id
        self.postCategoryType = category
        super.init()
    }
}
