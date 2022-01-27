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
let TEST_CHAT_ROOM_ID = 19
let TEST_OPPONENT_ID = 22
let TEST_MY_ID = 21


class ChatroomVC: UIViewController{
    var opponentNickname: String?
    var socketClient = StompClientLib()
    var chatroomID: Int = TEST_CHAT_ROOM_ID
    var chatContentList: [chatReceiveDto] = [chatReceiveDto]()
    let subscribeTopic = "/sub/chat/room/"
    let publishTopic = "/pub/chat/room/"
    var keyHeight: CGFloat?
    var opponentId: Int = TEST_OPPONENT_ID
    var myId : Int = TEST_MY_ID
    var mentorId : Int = 0
    var menteeId : Int = 0
    var mentoringId : Int = 0
    
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet var chatTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        let ud = UserDefaults.standard
        self.myId = ud.integer(forKey: "myId")
        NSLog("my Id : \(self.myId)")
        registerXib()
        self.chatOpponentNameLabel.text = self.opponentNickname
        self.chatTableView.delegate = self
        self.chatTableView.dataSource = self
        getMentorMenteeId()
        setupTextViewUI()
        registerSocket()
        getChattingHistory()
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
            let topic = self.publishTopic + "\(self.chatroomID)/message"
            let params = chatDto(roomId: self.chatroomID, writer: "yunseong", content: messageString, dateTime: getCurrentTimeDouble(), type: MessageType.MESSAGE.rawValue)
            NSLog("publish topic : \(topic)")
            socketClient.sendJSONForDict(dict: params.contentsDictionary, toDestination: topic)
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
        let accessToken = ud.string(forKey: "accessToken")!
        NSLog("accessToken : \(accessToken)")
        let connectHeader = [
            "Authorization" : "bearer \(accessToken)",
            "Content-Type" : "application/json;charset=UTF-8"
        ]
        NSLog("connect Header : \(connectHeader)")
        // socketClient.openSocketWithURLRequest(request: NSURLRequest(url: wsurl as URL), delegate: self as StompClientLibDelegate)
        socketClient.openSocketWithURLRequest(request: NSURLRequest(url: wsurl as URL), delegate: self as StompClientLibDelegate, connectionHeaders: connectHeader)
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
                print("request fail")
            }
        }
    }
    
    func setupTextViewUI(){
        self.messageTextView.layer.cornerRadius = 5
    }
    
    func getCurrentTimeDouble() -> Double{
        return Date.now.timeIntervalSince1970
    }
    
    func getTimeClockFormat(time: Double) -> String{
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        let clockTime = formatter.string(from: date)
        return clockTime
    }
    
    func getMentorMenteeId(){
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://" + mainAddress + "/chat/room/\(self.chatroomID)"
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
    
        AF.request(request).responseString{ (response) in
            switch response.result {
            case .success:
                let JSON = try! JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: Any]
                self.mentorId = JSON["mentorId"] as! Int
                self.menteeId = JSON["menteeId"] as! Int
                NSLog("mentorId : \(self.mentorId)")
                NSLog("menteeId : \(self.menteeId)")
            case .failure:
                    NSLog("Error occured")
            }
        }
    }
    
    func registerXib(){
        let MentoringRequestMenteeSystemTableViewCellNib = UINib(nibName: "MentoringRequestMenteeSystemTableViewCell", bundle: nil)
        let MentoringAcceptMenteeSystemTableViewCellNib = UINib(nibName: "MentoringAcceptMenteeSystemTableViewCell", bundle: nil)
        let ScheduleRequestMenteeSystemTableViewCellNib = UINib(nibName: "ScheduleRequestMenteeSystemTableViewCell", bundle: nil)
        let RegisterScheduleMenteeSystemTableViewCellNib = UINib(nibName: "RegisterScheduleMenteeSystemTableViewCell", bundle: nil)
        let ScheduleAcceptMenteeSystemTableViewCellNib = UINib(nibName: "ScheduleAcceptMenteeSystemTableViewCell", bundle: nil)
        let MentoringRequestMentorSystemTableViewCellNib = UINib(nibName: "MentoringRequestMentorSystemTableViewCell", bundle: nil)
        let MentoringAcceptMentorSystemTableViewCellNib = UINib(nibName: "MentoringAcceptMentorSystemTableViewCell", bundle: nil)
        let ScheduleRequestMentorSystemTableViewCellNib = UINib(nibName: "ScheduleRequestMentorSystemTableViewCell", bundle: nil)
        let ScheduleAcceptMentorSystemTableViewCellNib = UINib(nibName: "ScheduleAcceptMentorSystemTableViewCell", bundle: nil)
        let EmptyTableViewCellNib = UINib(nibName: "EmptyTableViewCell", bundle: nil)
        
        self.chatTableView.register(MentoringRequestMenteeSystemTableViewCellNib, forCellReuseIdentifier: "MentoringRequestMenteeSystemTableViewCell")
        self.chatTableView.register(MentoringAcceptMenteeSystemTableViewCellNib, forCellReuseIdentifier:"MentoringAcceptMenteeSystemTableViewCell")
        self.chatTableView.register(ScheduleRequestMenteeSystemTableViewCellNib, forCellReuseIdentifier: "ScheduleRequestMenteeSystemTableViewCell")
        self.chatTableView.register(RegisterScheduleMenteeSystemTableViewCellNib, forCellReuseIdentifier: "RegisterScheduleMenteeSystemTableViewCell")
        self.chatTableView.register(ScheduleAcceptMenteeSystemTableViewCellNib, forCellReuseIdentifier: "ScheduleAcceptMenteeSystemTableViewCell")
        self.chatTableView.register(MentoringRequestMentorSystemTableViewCellNib, forCellReuseIdentifier: "MentoringRequestMentorSystemTableViewCell")
        self.chatTableView.register(MentoringAcceptMentorSystemTableViewCellNib, forCellReuseIdentifier: "MentoringAcceptMentorSystemTableViewCell")
        self.chatTableView.register(ScheduleRequestMentorSystemTableViewCellNib, forCellReuseIdentifier: "ScheduleRequestMentorSystemTableViewCell"
        )
        self.chatTableView.register(ScheduleAcceptMentorSystemTableViewCellNib, forCellReuseIdentifier: "ScheduleAcceptMentorSystemTableViewCell")
        self.chatTableView.register(EmptyTableViewCellNib, forCellReuseIdentifier: "EmptyTableViewCell")
        
    }
    
    func getChattingHistory(){
        print("call history")
        let ud = UserDefaults.standard
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://" + mainAddress + "/chat/room/\(self.chatroomID)/message/history"
        var request = URLRequest(url: URL(string: apiURL)!)
        let accessToken = ud.string(forKey: "accessToken")!
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
            AF.request(request).responseData{ (dataResponse) in
                switch dataResponse.result {
                case .success(let value):
                    do {
                        let dataList = try JSONSerialization.jsonObject(with: value, options: []) as! [[String: Any]]
                        
                        for data in dataList {
                            NSLog("data : \(data)")
                            
                            let id: Int = data["id"] as! Int
                            let chatroomId: Int = data["chatroomId"] as! Int
                            let writerId: Int? = data["writerId"] as? Int
                            let writerPictureIndex: Int? = data["writerPictureIndex"] as? Int
                            let writerNickname :String? = data["writerNickname"] as? String
                            let type: String = data["type"] as! String
                            let content: String? = data["content"] as? String
                            let dateTime: Double = data["dateTime"] as! Double
                            let requestId: Int? = data["requestId"] as? Int
                            
                            let chatContent: chatReceiveDto = chatReceiveDto(id: id, chatroomId: chatroomId, writerId: writerId ?? 0, writerPictureIndex: writerPictureIndex ?? 0, writerNickname: writerNickname ?? "unKnowned", type: type, content: content ?? "", dateTime: dateTime, requestId: requestId ?? 0)
                            
                            
                            self.chatContentList.append(chatContent)
                            NSLog("chatContentList : \(self.chatContentList)")
                            
                            self.chatTableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic)
                            self.scrollToBottom()
                        }
                    } catch {print(error.localizedDescription)}
                case .failure(let error):
                        NSLog("load error : \(error)")
                }
            }
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
        // 시스템 메세지 출력
        if self.chatContentList[indexPath.row].type != "MESSAGE"{
            // 내가 멘토일 때
            if self.myId == mentorId{
                if self.chatContentList[indexPath.row].type == "MENTOR_SYSTEM"{
                    switch self.chatContentList[indexPath.row].content{
                    case "MENTORING_REQUEST":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "MentoringRequestMentorSystemTableViewCell", for: indexPath) as! MentoringRequestMentorSystemTableViewCell
                        return cell
                    case "MENTORING_ACCEPT":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "MentoringAcceptMentorSystemTableViewCell" , for: indexPath) as! MentoringAcceptMentorSystemTableViewCell
                        return cell
                    case "SCHEDULE_REQUEST":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleRequestMentorSystemTableViewCell", for: indexPath) as! ScheduleRequestMentorSystemTableViewCell
                        return cell
                    case "SCHEDULE_ACCEPT":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleAcceptMentorSystemTableViewCell", for: indexPath) as! ScheduleAcceptMentorSystemTableViewCell
                        return cell
                    default:
                        break
                    }
               }
            }
            if self.myId == menteeId{
                if self.chatContentList[indexPath.row].type == "MENTEE_SYSTEM"{
                    switch self.chatContentList[indexPath.row].content{
                    case "MENTORING_REQUEST":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "MentoringRequestMenteeSystemTableViewCell", for: indexPath) as! MentoringRequestMenteeSystemTableViewCell
                        return cell
                    case "MENTORING_ACCEPT":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "MentoringAcceptMenteeSystemTableViewCell", for: indexPath) as! MentoringAcceptMenteeSystemTableViewCell
                        return cell
                    case "SCHEDULE_REQUEST":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleRequestMenteeSystemTableViewCell", for: indexPath) as! ScheduleRequestMenteeSystemTableViewCell
                        return cell
                    case "SCHEDULE_ACCEPT":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleAcceptMenteeSystemTableViewCell", for: indexPath) as! ScheduleAcceptMenteeSystemTableViewCell
                        return cell
                    case "REGISTER_SCHEDULE":
                        let cell = tableView.dequeueReusableCell(withIdentifier: "RegisterScheduleMenteeSystemTableViewCell" , for: indexPath) as! RegisterScheduleMenteeSystemTableViewCell
                        cell.touchUpRegisterScheduleButton = {
                            let storyboard = UIStoryboard(name: "CalendarStoryboard", bundle: nil)
                            let nextVC = storyboard.instantiateViewController(withIdentifier: "NewMentoringRegisterVC") as! NewMentoringRegisterVC
                            self.present(nextVC, animated: true, completion: nil)
                        }
                        return cell
                    default:
                        break
                    }
                }
            }
        }
        // 내가 보낸 메세지 보여주기
        if self.chatContentList[indexPath.row].type == "MESSAGE"{
            if self.chatContentList[indexPath.row].writerId == self.myId {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTVC", for: indexPath) as! ChatTVC
                return makeSendMessageTableViewCell(cell: cell, indexPath: indexPath, dateTime: self.chatContentList[indexPath.row].dateTime)
            }
            // 상대방 메세지 보여주기
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatOpponentTVC", for: indexPath) as! ChatOpponentTVC
            return makeReceiveMessageTableViewCell(cell: cell, indexPath: indexPath, dateTime: self.chatContentList[indexPath.row].dateTime)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath) as! EmptyTableViewCell
        return cell
        
    }
    
    func printCellDataLog(cell: ChatTVC, indexPath: IndexPath){
        NSLog("cell.nickname.label : \(cell.nicknameLabel.text!)")
        NSLog("cell.content.label : \(cell.contentLabel.text!)")
        NSLog("success cell in text writer : \(self.chatContentList[indexPath.row].writerNickname)")
        NSLog("success cell in text content : \(self.chatContentList[indexPath.row].content)")
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
    
    func makeSendMessageTableViewCell(cell: ChatTVC, indexPath: IndexPath, dateTime: Double) -> UITableViewCell {
        let dateTimeNowString = self.getTimeClockFormat(time: self.chatContentList[indexPath.row].dateTime)
        cell.nicknameLabel?.text = self.chatContentList[indexPath.row].writerNickname
        cell.contentLabel?.text = self.chatContentList[indexPath.row].content
        cell.contentLabel?.layer.masksToBounds = true
        cell.contentLabel?.layer.cornerRadius = 5
        cell.timeLabel?.text = dateTimeNowString
        return cell
    }
    
    func makeReceiveMessageTableViewCell(cell: ChatOpponentTVC, indexPath: IndexPath, dateTime: Double) -> UITableViewCell{
        let dateTimeString = self.getTimeClockFormat(time: self.chatContentList[indexPath.row].dateTime)
        cell.opponentNicknameLabel?.text = self.chatContentList[indexPath.row].writerNickname
        cell.contentLabel?.text = self.chatContentList[indexPath.row].content
        cell.contentLabel?.layer.masksToBounds = true
        cell.contentLabel?.layer.cornerRadius = 5
        cell.timeLabel?.text = dateTimeString
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
            let chatContent :chatReceiveDto = chatReceiveDto(id: chatJSON["id"] as! Int, chatroomId: chatJSON["chatroomId"] as! Int, writerId: chatJSON["writerId"] as! Int, writerPictureIndex: chatJSON["writerPictureIndex"] as! Int, writerNickname: chatJSON["writerNickname"] as! String, type: chatJSON["type"] as! String, content: chatJSON["content"] as! String, dateTime: chatJSON["dateTime"] as! Double, requestId: chatJSON["requestId"] as? Int)
            
            if chatContent.requestId != nil{
                let ud = UserDefaults.standard
                ud.set(chatContent.requestId, forKey: "mentoringRequestId")
                NSLog("requestId : \(chatContent.requestId!)")
            }
            self.chatContentList.append(chatContent)
            NSLog("success append chat Content : \(chatContent.debugPrint())")
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
        NSLog("subscribe topic : \(topic)")
        NSLog("socket is connected : \(topic)")
        let ud = UserDefaults.standard
        let accessToken = ud.string(forKey: "accessToken")!
        let header = [
            "Authorization" : "bearer \(accessToken)",
            "Content-Type" : "application/json;charset=UTF-8",
            "id" : "1"
            
        ]
        socketClient.subscribeWithHeader(destination: topic, withHeader: header)
    }
    
    func serverDidSendReceipt(client: StompClientLib!, withReceiptId receiptId: String) {
        print("Receipt : \(receiptId)")
    }

    func serverDidSendError(client: StompClientLib!, withErrorMessage description: String, detailedErrorMessage message: String?) {
        NSLog("serverDidSendError")
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
    
    func mentoringRequestMenteeSystem() {
            
    }
    
    func sendChatBotTest(){
    }
}
