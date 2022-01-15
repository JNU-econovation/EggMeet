//
//  ChatroomVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/11.
//

import Foundation
import UIKit
import StompClientLib
import Alamofire

class ChatroomVC: UIViewController, StompClientLibDelegate{
    var nickname: String?
    var socketClient = StompClientLib()
    var url = NSURL()
    var subscribeTopic = "/sub/chat/room/"
    var chatroomID: Int = 0
    
    
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatOpponentNameLabel.text = self.nickname
        createChatRoom()
        registerSocket()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.messageTextView.endEditing(true)
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        socketClient.disconnect()
    }
    
    @IBAction func stopWebSocket(_ sender: Any) {
        
    }
    
    @IBAction func passMessage(_ sender: Any) {
        // pass Message Logic
        let messageString = messageTextView.text
        if messageString == ""{
            return
        } else {
            socketClient.sendMessage(message: messageString!, toDestination: "/stomp/chat", withHeaders: nil, withReceipt: nil)
            self.messageTextView.text = ""
        }
    }
    
    func updateUI() {
        if let nickname = nickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
    
    func registerSocket(){
        // 완전한 URL을 의미한다.
        let baseURL = Bundle.main.infoDictionary!["WS_URL"] as? String ?? ""
        let completeURL = "ws://" + baseURL + "/stomp-chat"
        let wsurl = NSURL(string: completeURL)!
        print(wsurl)
        NSLog("URL : \(completeURL)")
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: wsurl as URL), delegate: self as StompClientLibDelegate)
    }
    
    func stompClientDidConnect(client: StompClientLib!) {
        let topic = self.subscribeTopic + "\(chatroomID)"
        NSLog("\(topic)")
        print("socket is connected : \(topic)")
        socketClient.subscribe(destination: topic)
    }
    
    func stompClientDidDisconnect(client: StompClientLib!) {
        NSLog("Socket is Disconnected")
    }
    
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        NSLog("DESTINATION : \(destination)")
        print("JSON BODY : \(String(describing: jsonBody))")
        print("STRING BODY : \(stringBody ?? "nil")")
    }
    
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
         print("DESTINATION : \(destination)")
         print("String JSON BODY : \(String(describing: jsonBody))")
     }
     
     func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
         print("Receipt : \(receiptId)")
     }
     
     func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
         print("Error : \(String(describing: message))")
     }
     
     func serverDidSendPing() {
         print("Server Ping")
     }
    
    func createChatRoom(){
        let id: Int = 1     // chatroom number
        let baseURL = Bundle.main.infoDictionary!["WS_URL"] as? String ?? ""
        let postURL = "http://" + baseURL + "/chat/room"
        let param = ChatroomID(id: id)
        
        AF.request(postURL, method: .post, parameters: param, encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
            if response.response?.statusCode == 200 {
                self.chatroomID = id
            } else {
                print("")
            }
        }
    }
    
     
}

