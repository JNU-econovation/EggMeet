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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let nickname = nickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
    
    
}
