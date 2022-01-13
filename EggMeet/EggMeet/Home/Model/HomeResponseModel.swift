//
//  HomeResponseModel.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation

struct HomeResponseModel: Codable {
    let age: Int
    let description: String
    let location: Location
    let menteeCategory: Category
    let menteeDescription: String
    let menteeRating: Float
    let mentorCareer: String
    let mentorDescription: String
    let mentorGrowthPoint: Int
    let mentorLink: String
    let mentorRating: Float
    let nickname: String
    let isOfflineAvailable: Bool
    let isOnlineAvailable: Bool
    let pictureIndex: Int
    let sex: Sex
}


