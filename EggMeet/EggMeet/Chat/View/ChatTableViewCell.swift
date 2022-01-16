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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
