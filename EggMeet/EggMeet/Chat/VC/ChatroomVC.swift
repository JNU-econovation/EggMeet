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



    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    

    func updateUI() {
        if let nickname = nickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
}

