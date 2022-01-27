//
//  NewMentoringScheduleModel.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/28.
//

import Foundation

struct NewMentoringScheduleModel : Codable {
    
    var dateTime : Double
    
    init(dateTime : Double ){
        self.dateTime = dateTime
        
    }
}
