//
//  TotalMentoringTVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/23.
//

import Foundation
import UIKit

class TotalMentoringTVC: UITableViewCell {
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
