//
//  ScheduleRequestMentorSystemTableViewCell.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/26.
//

import UIKit
import Alamofire

class ScheduleRequestMentorSystemTableViewCell: UITableViewCell {

    @IBOutlet var scheduleAcceptButton: UIButton!
    
    var scheduleAcceptAction: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchUpScheduleAcceptButton(_ sender: Any?){
        scheduleAcceptAction?()
    }
    
}
