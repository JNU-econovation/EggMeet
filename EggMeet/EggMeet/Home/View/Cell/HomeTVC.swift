//
//  HomeTVCTableViewCell.swift
//  EggMeet
//
//  Created by asong on 2022/01/11.
//

import UIKit

class HomeTVC: UITableViewCell {
    //static let identifier = "HomeTVC"
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var growthCostLabel: UILabel!
    @IBOutlet weak var mentorGrowthPointLabel: UILabel!
    @IBOutlet weak var firstCategoryLabel: UILabel!
    @IBOutlet weak var secondCategoryLabel: UILabel!
    @IBOutlet weak var firstHashtagLabel: UILabel!
    @IBOutlet weak var secondHashtagLabel: UILabel!
    @IBOutlet weak var thirdHashtagLabel: UILabel!
    @IBOutlet weak var fourthHashtagLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
