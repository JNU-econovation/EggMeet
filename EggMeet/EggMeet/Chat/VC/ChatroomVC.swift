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
        self.chatOpponentNameLabel.text = self.opponentNickname
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        self.chatTableView.rowHeight = UITableView.automaticDimension
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
    
    @IBAction func passMessage(_ sender: UIButton) {
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
        
        if let data = stringBody?.data(using: .utf8){
            let chatJSON = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let chatContent :chatDto = chatDto(roomId: chatJSON["roomId"] as! Int, writer: chatJSON["writer"] as! String, message: chatJSON["message"] as! String)
            self.chatContentList.append(chatContent)
            NSLog("success append chat Content : \(chatContent)")
            NSLog("chatContentList : \(self.chatContentList)")
        }
        self.chatTableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("section : \(section)")
        return self.chatContentList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        tableView.rowHeight = UITableView.automaticDimension
        NSLog("comming cellForRowAt")
        cell.nicknameLabel?.text = self.chatContentList[indexPath.row].writer
        cell.contentLabel?.text = self.chatContentList[indexPath.row].message
        
        NSLog("cell.nickname.label : \(cell.nicknameLabel.text!)")
        NSLog("cell.content.label : \(cell.contentLabel.text!)")
        
        NSLog("success cell in text writer : \(self.chatContentList[indexPath.row].writer)")
        NSLog("success cell in text content : \(self.chatContentList[indexPath.row].message)")
        
        return cell
    }
    
    
}


