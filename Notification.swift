//
//  Notification.swift
//  NypSddpProject
//
//  Created by iOS on 26/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class Notification: NSObject {
    
    var notificationId : Int!
    var notificationCategory : String!
    
    
    var notifDesc: String!
    var dateToNotified : Double!
    var convertedDateToNotified : String!
    var hasNotified : Int!
    var commentId: Int!
    var postId: Int!
    var userId: Int!
    
    
    
    //load notification by category
    init (id: Int, category: String)
    {
        self.notificationId = id
        self.notificationCategory = category
    }
    
 
    //insert notificationComment
    init (desc: String, dateToNotified: Double, hasNotified: Int, notificationId : Int, commentId: Int, userId: Int)
    {
        self.notifDesc = desc
        self.dateToNotified = dateToNotified
        self.hasNotified = hasNotified
        self.notificationId = notificationId
        self.commentId = commentId
        self.userId = userId
    }
    
    //select user notification
    init (desc: String, convertedDateToNotified: String, hasNotified: Int, notificationId : Int, commentId: Int, postId: Int, userId: Int)
    {
        self.notifDesc = desc
        self.convertedDateToNotified = convertedDateToNotified
        self.hasNotified = hasNotified
        self.notificationId = notificationId
        self.commentId = commentId
        self.postId = postId
        self.userId = userId
    }
    
    
    //delete notification
    init (notificationId: Int, commentId: Int, userId: Int)
    {
        self.notificationId = notificationId
        self.commentId = commentId
        self.userId = userId
    }
}
