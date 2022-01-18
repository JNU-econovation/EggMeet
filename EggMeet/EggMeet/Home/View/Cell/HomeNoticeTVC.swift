//
//  HomeNoticeTVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/18.
//

import UIKit

class HomeNoticeTVC: UITableViewCell {
    
    @IBOutlet weak var noticeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
