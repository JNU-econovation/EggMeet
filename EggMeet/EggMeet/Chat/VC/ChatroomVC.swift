//
//  ChatroomVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/11.
//

import Foundation
import UIKit
import SocketIO

class ChatroomVC: UIViewController, UITextFieldDelegate {
    var nickname: String?
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var botViewLayout: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var myChat: [chatType] = []
    var socket: SocketIOClient!
    var keyboardHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.socket = SocketIOManager.shared.socket
        bindMsg()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // initGestureRecognizer()
        // registerForKeyboardNotifications()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SocketIOManager.shared.closeConnection()
        // unregisterForKeyboardNotifications()
    }
    
    // 서버로 부터 메세지 받을 때 채팅창 업데이트
    func bindMsg(){
        self.socket.on("test") { (dataArray, socketAck) in
            var chat = chatType()
            print("--------------------")
            print(type(of: dataArray))
            let data = dataArray[0] as! NSDictionary
            
            chat.type = data["type"] as! Int
            chat.message = data["message"] as! String
            self.myChat.append(chat)
            print(chat)
            
            self.updateChat(count: self.myChat.count) { print("Get Message") }
        }
    }
    
    // 채팅 업데이트
    func updateChat(count: Int, completion: @escaping ()->Void) {
        let indexPath = IndexPath(row: count-1, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: .none)
        self.tableView.endUpdates()
        
        self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        
        completion()
    }
    
    // 전송 버튼
    @IBAction func sendMsgButtonClick(_ sender: Any){
        let text = self.textField.text!
        self.socket.emit("test", text)
        self.myChat.append(chatType(type:0, message: text))
        self.updateChat(count: self.myChat.count) {
            print("Send Message")
        }
    }
    
    func updateUI() {
        if let nickname = nickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
}

extension ChatroomVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.myChat.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = self.myChat[indexPath.row].type == 0 ? "MyCell" : "YourCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatTVC
        cell.chatLabel.text = self.myChat[indexPath.row].message
        return cell
    }
}

extension ChatroomVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let chat = myChat[indexPath.row]
        
        let widthOfText = view.frame.width - 122 - 40
        let size = CGSize(width: widthOfText, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        let estimatedFrame = NSString(string: chat.message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return estimatedFrame.height + 14 + 14 + 4
    }
}
