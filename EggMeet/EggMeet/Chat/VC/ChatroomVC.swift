//
//  ChatroomVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/11.
//

import Foundation
import UIKit

class ChatroomVC: UIViewController {
    var nickname: String?
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func disconnectSocket(_ sender: Any){
        SocketIOManager.shared.closeConnection()
    }
    
    @IBAction func connectSocket(_ sender: Any){
        SocketIOManager.shared.establishConnection()
    }
    
    @IBAction func sendData(_ sender: Any){
        SocketIOManager.shared.sendMessage(message: self.textField.text!, nickname: "ns")
    }
    
    func updateUI() {
        if let nickname = nickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
}
