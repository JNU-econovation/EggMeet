//
//  MentoringRequestMentorSystemTableViewCell.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/26.
//

import UIKit
import Alamofire

class MentoringRequestMentorSystemTableViewCell: UITableViewCell {

    @IBOutlet var mentoringAcceptButton : UIButton!

    var mentoringAcceptAction: (() -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchUpMentoringAcceptButton(_ sender: Any?){
        mentoringAcceptAction?()
    }
    
}
