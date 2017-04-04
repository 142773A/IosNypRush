//
//  School.swift
//  NypSddpProject
//
//  Created by Foxlita on 22/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class School: NSObject {
    
    var SchoolId : Int
    var SchoolName : String
    var SchoolShortName : String

    init( SchoolId : Int, SchoolName : String, SchoolShortName : String ) {
        self.SchoolId = SchoolId
        self.SchoolName =  SchoolName
        self.SchoolShortName = SchoolShortName

        
        
    }
    
    
}
