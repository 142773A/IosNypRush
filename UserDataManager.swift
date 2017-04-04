//
//  UserDataManager.swift
//  NypSddpProject
//
//  Created by iOS on 6/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class UserDataManager: NSObject {

    //retrieve
    // retrieve selected user by username (unique)
    
    static func loadUserByUsername(username : String) -> User
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM User WHERE Username= '"+username+"'")
        
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
    
    
    
    static func loadUserById(userId : String) -> User
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM User WHERE UserId = '" + userId + "'")
        
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
    
    
    
    
    static func loadUserByUsernamePassword(username : String, password: String) -> Any?
    {
        let userRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM User WHERE Username= '"+username+"'AND Password= '"+password+"'")
        
        var user : User! = nil
        
        for row in userRow{
            
            user = User(userId: row["UserId"] as! Int,
                        name: row["Name"] as! String,
                        shortname: row["Shortname"] as! String,
                        username: row["Username"] as! String,
                        password: row["Password"] as! String,
                        roleId: row["RoleId"] as! Int,
                        year: row["Year"] as! Int)
        }
        if(user != nil){
            return user;
        }
        else{
            return nil
        }
        
        
    }
    

    
    static func loadUserByUserId(id:String) -> User
    {
        let userRow = SQLiteDB.sharedInstance.query(sql: "SELECT * FROM User WHERE UserId= '"+id+"'")
        
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
    
    
    
   
}
