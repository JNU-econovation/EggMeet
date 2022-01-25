//
//  chatDto.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/15.
//

import Foundation

struct chatDto {
    var roomId : Int
    var writer : String
    var message :String
    
    var dictionary: [String: Any] {
        return [
            "roomId" : roomId,
            "writer" : writer,
            "message" : message
        ]
    }
    
    var nsDictionary: NSDictionary{
        return dictionary as NSDictionary
    }
    
    func debugPrint(){
        NSLog("roomID : \(roomId)")
        NSLog("writer : \(writer)")
        NSLog("message : \(message)")
    }
}
