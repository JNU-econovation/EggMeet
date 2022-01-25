//
//  HomeResponseModel.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation
import UIKit

struct HomeProfileModel: Codable {
    var age: Int
    var description: String
    var location: String
    var menteeCategory: String
    var menteeDescription: String
    var menteeRating: Float
    var mentorCareer: String
    var mentorCategory: String
    var mentorDescription: String
    var mentorGrowthCost: Int
    var mentorLink: String
    var mentorRating: Float
    var nickname: String
    var isOfflineAvailable: Int
    var isOnlineAvailable: Int
    var pictureIndex: Int
    var sex: String
    
    init(age: Int, description: String, location: String,menteeCategory: String, menteeDescription: String, menteeRating: Float, mentorCareer: String, mentorCategory: String, mentorDescription: String, mentorGrowthCost: Int, mentorLink: String, mentorRating: Float, nickname: String, isOfflineAvailable: Int, isOnlineAvailable: Int, pictureIndex: Int, sex: String){
        self.age = age
        self.description = description
        self.location = location
        self.menteeCategory = menteeCategory
        self.menteeDescription = menteeDescription
        self.menteeRating = menteeRating
        self.mentorCareer = mentorCareer
        self.mentorCategory = mentorCategory
        self.mentorDescription = mentorDescription
        self.mentorGrowthCost = mentorGrowthCost
        self.mentorLink = mentorLink
        self.mentorRating = mentorRating
        self.nickname = nickname
        self.isOfflineAvailable = isOfflineAvailable
        self.isOnlineAvailable = isOnlineAvailable
        self.pictureIndex = pictureIndex
        self.sex = sex
    }
}
