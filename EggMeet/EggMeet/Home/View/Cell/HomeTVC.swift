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
    @IBOutlet weak var firstHashtagLabel: UILabel!
    @IBOutlet weak var areaImageView: UIImageView!

    let imageList = ["origin_egg", "gold_egg","brown_egg"]
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension HomeTVC {
    func initCell(image: Int, nickname: String, rating: Float, mentorGrowthPoint: Int, firstCategory: String , location: Location, isOnline: Int, isOffline: Int, age: Int, sex: Sex, isMentor: Bool){
        nicknameLabel.text = nickname
        nicknameLabel.adjustsFontSizeToFitWidth = true
        mentorGrowthPointLabel.text = "\(mentorGrowthPoint) point"
        firstCategoryLabel.text = firstCategory
        profileImageView.image = UIImage(named: imageList[image])
        
        var hashtagStr: String = ""
        switch location {
            case .ALL : hashtagStr = "#전체  "
            default : hashtagStr = "#\(location)"
        }
        var onlineText = ""
        
        switch isOnline{
            case 1 : onlineText = "#온라인  "
            default : onlineText = "" }
        
        switch isOffline{
            case 1 : onlineText += "#오프라인  "
            default : hashtagStr += "" }
        hashtagStr += onlineText
        hashtagStr += "#\(age)대  "
        
        switch sex {
        case .UNDEFINED : hashtagStr += ""
        case .FEMALE : hashtagStr += "#여성  "
        case .MALE : hashtagStr += "#남성  "
        }
        firstHashtagLabel.text = hashtagStr
        
        switch isMentor {
        case false : growthCostLabel.text = ""; mentorGrowthPointLabel.text = ""
            areaImageView.image = UIImage(named: "home_area_mentee")
        default : growthCostLabel.text = "성장비용"
            areaImageView.image = UIImage(named: "home_area_mentor")
        }
    }
}
