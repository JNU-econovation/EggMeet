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
    var content: String
    var dateTime : Double
    var type : String
    
    var dictionary: [String: Any] {
        return [
            "roomId" : roomId,
            "writer" : writer,
            "content" : content,
            "dateTime" : dateTime,
            "type" : type
        ]
    }
    
    var stringDictionary : [String: Any]{
        return ["content" : content]
    }
    var nsDictionary: NSDictionary{
        return dictionary as NSDictionary
    }
    
    var contentsDictionary: NSDictionary{
        return stringDictionary as NSDictionary
    }
    
    func debugPrint(){
        NSLog("roomID : \(roomId)")
        NSLog("writer : \(writer)")
        NSLog("content : \(content)")
        NSLog("dateTime : \(dateTime)")
        NSLog("type : \(type)")
    }
}
