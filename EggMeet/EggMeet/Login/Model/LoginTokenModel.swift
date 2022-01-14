//
//  LoginTokenModel.swift
//  EggMeet
//
//  Created by asong on 2022/01/14.
//

import Foundation

struct LoginTokenModel: Codable {
    let accessToken: String
    let accessTokenExpiresIn: Int
    let grantType: String
    let refreshToken: String
}
