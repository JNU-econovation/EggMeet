//
//  SocketIOManager.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/11.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject{
    static let shared = SocketIOManager()
    var manager = SocketManager(socketURL: URL(string: "http://localhost:9000")!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    
    override init(){
        super.init()
        socket = self.manager.socket(forNamespace: "/test")
        
        socket.on("test") { dataArray, ack in
            print(dataArray)
        }
    }
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
    
    func sendMessage(message: String, nickname: String) {
        socket.emit("event", ["message":"test"])
        socket.emit("event1", [["name": "ns"], ["email" : "@naver.com"]])
        socket.emit("event2", ["name" : "ns", "email" : "@naver.com" ])
        socket.emit("msg", ["nick":nickname, "msg" : message])
    }
}
