//
//  ChatTableViewCell.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/16.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var nicknameLabel : UILabel!
    @IBOutlet var contentLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
