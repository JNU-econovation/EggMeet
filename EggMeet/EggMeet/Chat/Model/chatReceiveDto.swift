//
//  chatReceiveDto.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/26.
//

import Foundation

struct chatReceiveDto{
    var id: Int
    var chatroomId: Int
    var writerId: Int
    var writerPictrureIndex: Int
    var writerNickname: String
    var type : String
    var content : String
    var dateTime : Double
    
    func debugPrint(){
        NSLog("id \(id)")
        NSLog("chatroomId : \(chatroomId)")
        NSLog("writerId : \(writerId)")
        NSLog("writerPictureIndex : \(writerPictrureIndex)")
        NSLog("writerNickname : \(writerNickname)")
        NSLog("type : \(type)")
        NSLog("content : \(content)")
        NSLog("dateTime : \(dateTime)")
    }
}
