//
//  NotificationDataManager.swift
//  NypSddpProject
//
//  Created by iOS on 25/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class NotificationDataManager: NSObject {

    
    //retrieve all users
    static func loadAllUsers() -> [User]
    {
        let userRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM User")
        
        var user : [User] = []
        
        for row in userRows
        {
            user.append(User(userId:
                row["UserId"] as! Int,
                name: row["Name"] as! String,
                shortname: row["Shortname"] as! String,
                username: row["Username"] as! String,
                password: row["Password"] as! String,
                roleId: row["RoleId"] as! Int,
                year: row["Year"] as! Int))
        }
        
        return user;
    }

    
    
    //retrieve all notificationCategory
    static func loadNotificationCategory() -> [Notification]
    {
        let categoryTypeRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM Notification ORDER BY Category ASC")
        
        var categoryType : [Notification] = []
        for row in categoryTypeRows
        {
            categoryType.append(Notification(
                id: row["NotificationId"] as! Int,
                category: row["Category"] as! String))
        }
        
        return categoryType;
    }

    //load notification by category
    static func loadNotification(category: String) -> [Notification]
    {
        let notificationRow = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM Notification WHERE Category = '" + category + "'")
        
        var notification : [Notification] = []
        
        for row in notificationRow{
            
            notification.append(Notification(id: row["NotificationId"] as! Int, category: row["Category"] as! String))
        }
        
        return notification
        
    }
    
    //insert notification
    static func insertNotification(notification : Notification) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(sql:
                "INSERT INTO NotificationComment  (Description, DateToNotified, HasNotified, NotificationId, CommentId, UserId) VALUES (?, ?, ?, ?, ?, ?)",
                 parameters: [
                 notification.notifDesc,
                 notification.dateToNotified,
                 notification.hasNotified,
                 notification.notificationId,
                 notification.commentId,
                 notification.userId])
            
            return true
        }
        catch {
            print("Insert failed")
            return false
        }
    }
    
    //retrieve all notification
    static func loadAllNotificationComment() -> [Notification]
    {
        let notificationRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM NotificationComment")
        
        var notification : [Notification] = []
        
        for row in notificationRows
        {
            notification.append(Notification(
                desc: row["Description"] as! String,
                dateToNotified: row["DateToNotified"] as! Double,
                hasNotified: row["HasNotified"] as! Int,
                notificationId: row["NotificationId"] as! Int,
                commentId: row["CommentId"] as! Int,
                userId: row["UserId"] as! Int))
        }
        
        return notification;
    }

    //retrieve all users
    static func loadUserNotification(userId : String, notificationId: String) -> [Notification]
    {
        let notificationRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT NotificationCommentId, NotificationComment.Description, NotificationComment.DateToNotified, NotificationComment.HasNotified, NotificationComment.NotificationId, NotificationComment.CommentId, NotificationComment.UserId, Comment.PostId FROM NotificationComment INNER JOIN Comment on NotificationComment.CommentId = Comment.CommentId WHERE NotificationComment.UserId != '" + userId + "' AND NotificationComment.NotificationId = '" + notificationId + "'")
        
        var notification : [Notification] = []
        
        for row in notificationRows
        {
            notification.append(Notification(
                desc: row["Description"] as! String,
                convertedDateToNotified: "\(row["DateToNotified"]!)" as! String,
                hasNotified: row["HasNotified"] as! Int,
                notificationId: row["NotificationId"] as! Int,
                commentId: row["CommentId"] as! Int,
                postId: row["PostId"] as! Int,
                userId: row["UserId"] as! Int))
        }
        
        return notification;
    }
    
    //delete notification
    static func deleteNotification(notification : Notification) -> Bool
    {
        do {
            let result = SQLiteDB.sharedInstance.execute(
                sql:"DELETE FROM NotificationComment WHERE NotificationId =? AND CommentId =? AND UserId =?",
                parameters: [notification.notificationId, notification.commentId, notification.userId])
            
            return true
        }
        catch {
            print("Delete failed")
            return false
        }
    }
    
    //update notification has notified
    static func updateNotification(notification : Notification) -> Bool
    {
        do {
            let hasNotified : String = "\(1)" // set to 1
            let result = SQLiteDB.sharedInstance.execute(
                sql:"UPDATE NotificationComment SET hasNotified = " + hasNotified + " WHERE notificationId =? AND commentId =? AND userId = ?",
                parameters: [notification.notificationId, notification.commentId, notification.userId])
            
            return true
        }
        catch {
            print("Update failed")
            return false
        }
    }

}
