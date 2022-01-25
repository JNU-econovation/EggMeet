//
//  ChatOpponentTVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/21.
//

import Foundation
import UIKit

class ChatOpponentTVC: UITableViewCell{
    @IBOutlet var opponentNicknameLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
