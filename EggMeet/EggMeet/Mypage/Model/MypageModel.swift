//
//  MypageModel.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/26.
//

import Foundation
import UIKit
struct MypageModel: Codable {

    var nickname: String
    var growthPoint: Int
    
    
    init(nickname: String,growthPoint: Int ){
        self.nickname = nickname
        self.growthPoint = growthPoint
        
    }
}

