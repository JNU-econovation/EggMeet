//
//  UserMentorResponseModel.swift
//  EggMeet
//
//  Created by asong on 2022/01/14.
//

import Foundation
import UIKit

struct UserMentorResponseModel: Codable {
    let age: Int
    let category: Category
    let growthPoint: Int
    let id: Int
    let location: Location
    let mentorRating: Float
    let nickname: String
    let isOfflineAvailable: Bool
    let isOnlineAvailable: Bool
    let sex: Sex
}
