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
    var opponentNickname: String?
    var socketClient = StompClientLib()
    var url = NSURL()
    let subscribeTopic = "/sub/chat/room/"
    let publishTopic = "/pub/chat/room/message"
    var chatroomID: Int = 1
    var chatContentList: [chatDto] = [chatDto]()
    
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet var chatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatOpponentNameLabel.text = self.opponentNickname
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        if !isExistChatRoom(){
            createChatRoom()
        }
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
        let messageString = messageTextView.text!
        if messageString == ""{
            return
        } else {
            let ud = UserDefaults.standard
            let topic = self.publishTopic
            let writer = ud.string(forKey: "nickname")!
            let params = chatDto(roomId: self.chatroomID, writer:writer, message: messageString)
            params.debugPrint()
            socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic) // if success, callback stompClient method
            self.messageTextView.text = ""
        }
    }
    
    func updateUI() {
        if let nickname = opponentNickname {
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
    
    // subscribe function
    func stompClientDidConnect(client: StompClientLib!) {
        let topic = self.subscribeTopic + "\(chatroomID)"
        NSLog("\(topic)")
        print("socket is connected : \(topic)")
        socketClient.subscribe(destination: topic)
    }
    
    // disconnect
    func stompClientDidDisconnect(client: StompClientLib!) {
        NSLog("Socket is Disconnected")
    }
    
    // send 시, 해당 로그를 출력한다.
    func stompClient(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: AnyObject?, akaStringBody stringBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
        NSLog("DESTINATION : \(destination)")
        NSLog("JSON BODY : \(String(describing: jsonBody))")
        NSLog("STRING BODY : \(stringBody ?? "nil")")
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
    
    // createChatRoom from id
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
    
    func isExistChatRoom() -> Bool{
        if self.chatroomID == 0{
            return false
        } else{
            return true
        }
    }
    
    func updateChat(){
        
    }
}

extension ChatroomVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatContentList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        cell.nicknameLabel.text = self.chatContentList[indexPath.row].writer
        cell.contentLabel.text = self.chatContentList[indexPath.row].message
        
        return cell
    }
}


