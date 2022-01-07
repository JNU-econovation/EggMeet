//
//  RegisterUser.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/07.
//

import Foundation
import UIKit
// JSON으로 보낼 구조체
struct RegisterUser {
    let age: String
    let description: String?
    let email: String?
    let location: String?
    let loginType: String
    let menteeCategory: String?
    let menteeDescription: String?
    let mentorCareer: String?
    let mentorCategory: String?
    let mentorDescription: String?
    let mentorLink: String?
    let name: String
    let offlineAvailable: Bool
    let onlineAvailable: Bool
    let phoneNumber: String?
    let pictureIndex: String?
    let role: String?
    let sex: String
    let socialToken: String
    
}
