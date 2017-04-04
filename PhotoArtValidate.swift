//
//  PhotoArtValidate.swift
//  NypSddpProject
//
//  Created by iOS on 26/1/17.
//  Copyright © 2017 NYP. All rights reserved.
//

import UIKit

class PhotoArtValidate: NSObject {

    var photoArtValidateId : Int
    var person : Int
    var gender : String
    var object : String
    var age : String
    var emotion : String
    var word : String
    var photoArtId : Int
    
    init(id: Int, person: Int, gender: String, object : String, age : String, emotion : String, word : String, photoArtID : Int) {
        self.photoArtValidateId = id
        self.person = person
        self.gender = gender
        self.object = object
        self.age = age
        self.emotion = emotion
        self.word = word
        self.photoArtId = photoArtID    
    }
}
