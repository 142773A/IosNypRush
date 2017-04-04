//
//  MysteryClueDataManager.swift
//  NypSddpProject
//
//  Created by Leon Tan on 13/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class MysteryClueDataManager: NSObject {

    static func loadClue() -> [CluedoClue]
    {
        let clueRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM CluedoClue ORDER BY ClueId ASC")
        
        var allClues : [CluedoClue] = []
        for row in clueRows
        {
            allClues.append(CluedoClue(
                id: row["ClueId"] as! Int,
                clueDescription: row["Description"] as! String,
                imagePath : row["Image"] as! String,
                lat : row["Lat"] as! Double,
                lng : row["Long"] as! Double,
                score : row["Score"] as! Int))
        }
        return allClues;
    }
    
    static func loadAnswer() -> [CluedoAnswer]
    {
        let clueRows = SQLiteDB.sharedInstance.query(sql:
            "SELECT * FROM CluedoAnswer ORDER BY CluedoAnswerId ASC")
        
        var allClues : [CluedoAnswer] = []
        for row in clueRows
        {
            allClues.append(CluedoAnswer(
                id: row["CluedoAnswerId"] as! Int,
                clueDescription: row["Description"] as! String,
                imagePath : row["Image"] as! String,
                lat : row["Lat"] as! Double,
                lng : row["Long"] as! Double,
                score : row["Score"] as! Int))
        }
        return allClues;
    }
    
    
}
	
