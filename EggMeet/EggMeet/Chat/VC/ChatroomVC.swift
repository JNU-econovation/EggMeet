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

let CHAT_SECTION_NUM = 1
let STATUS_OK = 200
let TEST_CHAT_ROOM_ID = 1

class ChatroomVC: UIViewController{
    var opponentNickname: String?
    var socketClient = StompClientLib()
    var chatroomID: Int = TEST_CHAT_ROOM_ID
    var chatContentList: [chatDto] = [chatDto]()
    let subscribeTopic = "/sub/chat/room/"
    let publishTopic = "/pub/chat/room/message"
    var keyHeight: CGFloat?
    
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet var chatTableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.chatOpponentNameLabel.text = self.opponentNickname
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        setupTextViewUI()
        if !isExistChatRoom(){
            createChatRoom()
        }
        registerSocket()
    }
    override func viewWillAppear(_ animated: Bool) {
        print("call viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        sendChatBotTest()
    }
    
    override func viewWillDisappear(_ animated: Bool) { 
        socketClient.disconnect()
    }
    
    @IBAction func passMessage(_ sender: UIButton) {
        // pass Message Logic
        let messageString = messageTextView.text!
        if messageString == ""{
            return
        } else {
            let topic = self.publishTopic
            let writer = setMyChatroomName()
            let params = chatDto(roomId: self.chatroomID, writer:writer, message: messageString)
            params.debugPrint()
            socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic) // if success, callback stompClient method
            self.messageTextView.text = ""
        }
    }
    
    @IBAction func popView(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    func setMyChatroomName() -> String{
        let ud = UserDefaults.standard
        let myName = ud.string(forKey: "nickname")!
        if  myName == ""{
            return "unKnowned"
        } else {
            return myName
        }
    }
    
    func updateUI() {
        if let nickname = opponentNickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
    
    func registerSocket(){
        let baseURL = Bundle.main.infoDictionary!["WS_URL"] as? String ?? ""
        let completeURL = "ws://" + baseURL + "/stomp-chat"
        let wsurl = NSURL(string: completeURL)!
        let ud = UserDefaults.standard
        let token = ud.string(forKey: "accessToken")!
        NSLog("Accesstoken : \(token)")
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: wsurl as URL), delegate: self as StompClientLibDelegate, connectionHeaders: ["Autorization" : "Bearer \(token)"])
    }
        
    func createChatRoom(){
        let id: Int = CHAT_SECTION_NUM     // chatroom number
        let baseURL = Bundle.main.infoDictionary!["WS_URL"] as? String ?? ""
        let postURL = "http://" + baseURL + "/chat/room"
        let param = ChatroomID(id: id)
        
        AF.request(postURL, method: .post, parameters: param, encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
            if response.response?.statusCode == STATUS_OK {
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
    
    func setupTextViewUI(){
        self.messageTextView.layer.cornerRadius = 5
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
        let ud = UserDefaults.standard
        let writer = ud.string(forKey: "nickname")
        let dateformat = DateFormatter()
        dateformat.dateFormat = "HH:mm"
        let currentTime = dateformat.string(from: Date())
        
        if self.chatContentList[indexPath.row].writer == writer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTVC", for: indexPath) as! ChatTVC
            return makeSendMessageTableViewCell(cell: cell, indexPath: indexPath, currentTime: currentTime)
        } else if self.chatContentList[indexPath.row].writer == "system"{
            switch self.chatContentList[indexPath.row].message{
            case "/mentor-request":
                let cell = tableView.dequeueReusableCell(withIdentifier: "SendMentorRequestTVC", for: indexPath) as! SendMentorRequestTVC
                return cell
            case "/welcome-chatroom":
                let cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeChatroomTVC", for: indexPath) as! WellcomeChatroomTVC
                return cell
            case "/register-schedule":
                let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterScheduleTVC", for: indexPath) as!
                    RegisterScheduleTVC
                return cell
            case "/confirm-mentoring":
                let cell = tableView.dequeueReusableCell(withIdentifier: "ConfirmMentoringTVC", for: indexPath) as! ConfirmMentoringTVC
                return cell
            case "/reject-mentoring":
                let cell = tableView.dequeueReusableCell(withIdentifier: "RejectMentoringTVC", for: indexPath) as! RejectMentoringTVC
                return cell
            default:
                NSLog("chat bot not send message")
            }

        }
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatOpponentTVC", for: indexPath) as! ChatOpponentTVC
            return makeReceiveMessageTableViewCell(cell: cell, indexPath: indexPath, currentTime: currentTime)

    }
    
    func printCellDataLog(cell: ChatTVC, indexPath: IndexPath){
        NSLog("cell.nickname.label : \(cell.nicknameLabel.text!)")
        NSLog("cell.content.label : \(cell.contentLabel.text!)")
        NSLog("success cell in text writer : \(self.chatContentList[indexPath.row].writer)")
        NSLog("success cell in text content : \(self.chatContentList[indexPath.row].message)")
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollToBottom(){
        print("numberOfSections : \(self.chatTableView.numberOfRows(inSection: CHAT_SECTION_NUM-1))")
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: (self.chatContentList.count - 1) , section: 0)
            self.chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func makeSendMessageTableViewCell(cell: ChatTVC, indexPath: IndexPath, currentTime: String) -> UITableViewCell {
        cell.nicknameLabel?.text = self.chatContentList[indexPath.row].writer
        cell.contentLabel?.text = self.chatContentList[indexPath.row].message
        cell.contentLabel?.layer.masksToBounds = true
        cell.contentLabel?.layer.cornerRadius = 5
        cell.timeLabel?.text = currentTime
        return cell
    }
    
    func makeReceiveMessageTableViewCell(cell: ChatOpponentTVC, indexPath: IndexPath, currentTime: String) -> UITableViewCell{
        cell.opponentNicknameLabel?.text = self.chatContentList[indexPath.row].writer
        cell.contentLabel?.text = self.chatContentList[indexPath.row].message
        cell.contentLabel?.layer.masksToBounds = true
        cell.contentLabel?.layer.cornerRadius = 5
        cell.timeLabel?.text = currentTime
        return cell
    }
}

extension ChatroomVC: StompClientLibDelegate {
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
        scrollToBottom()
    }
    
    // disconnect
    func stompClientDidDisconnect(client: StompClientLib!) {
        NSLog("Socket is Disconnected")
    }
    
    // subscribe function
    func stompClientDidConnect(client: StompClientLib!) {
        let topic = self.subscribeTopic + "\(chatroomID)"
        NSLog("\(topic)")
        print("socket is connected : \(topic)")
        socketClient.subscribe(destination: topic)
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
    
    func stompClientJSONBody(client: StompClientLib!, didReceiveMessageWithJSONBody jsonBody: String?, withHeader header: [String : String]?, withDestination destination: String) {
         print("DESTINATION : \(destination)")
         print("String JSON BODY : \(String(describing: jsonBody))")
     }
}


extension ChatroomVC : ChatBot {
    func sendMentorRequest(){
        let topic = self.publishTopic
        let params = chatDto(roomId: self.chatroomID, writer: "system", message: "/mentor-request")
        params.debugPrint()
        socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic)
    }
    
    func sendWelcomeChatroom() {
        let topic = self.publishTopic
        let params = chatDto(roomId: self.chatroomID, writer: "system", message: "/welcome-chatroom")
        params.debugPrint()
        socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic)
    }
    
    func sendRegisterSchedule() {
        let topic = self.publishTopic
        let params = chatDto(roomId: self.chatroomID, writer: "system", message: "/register-schedule")
        params.debugPrint()
        socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic)
    }
    
    func sendConfirmMentoring(){
        let topic = self.publishTopic
        let params = chatDto(roomId: self.chatroomID, writer: "system", message: "/confirm-mentoring")
        params.debugPrint()
        socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic)
    }
    
    func sendRejectMentoring() {
        let topic = self.publishTopic
        let params = chatDto(roomId: self.chatroomID, writer: "system", message: "/reject-mentoring")
        params.debugPrint()
        socketClient.sendJSONForDict(dict: params.nsDictionary, toDestination: topic)
    }
    
    func sendChatBotTest(){
        sendMentorRequest()
        sendWelcomeChatroom()
        sendRegisterSchedule()
        sendConfirmMentoring()
        sendRejectMentoring()
    }
}
