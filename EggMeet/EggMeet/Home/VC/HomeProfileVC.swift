//
//  HomeProfileVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/24.
//

import Foundation
import UIKit

class HomeProfileVC: UIViewController {
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var menteeCategoryLabel: UILabel!
    @IBOutlet weak var menteeDescriptionLabel: UILabel!
    @IBOutlet weak var mentorCareerLabel: UILabel!
    @IBOutlet weak var mentorCategoryLabel: UILabel!
    @IBOutlet weak var mentorDescriptionLabel: UILabel!
    @IBOutlet weak var mentorGrowthCostLabel: UILabel!
    @IBOutlet weak var mentorLinkLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.isHidden =  false
        setProfileData()
    }
    
    func setProfileData(){
        HomeNetwork.shared.getUserProfileData(id: id) { data in
            self.ageLabel.text = "\(data.age)대"
            self.descriptionLabel.text = data.description
            self.locationLabel.text = "광주광역시 북구"
            self.menteeCategoryLabel.text = data.menteeCategory
            self.menteeDescriptionLabel.text = data.menteeDescription
            self.mentorCareerLabel.text = data.mentorCareer
            self.mentorCategoryLabel.text = data.mentorCategory
            self.mentorDescriptionLabel.text = data.mentorDescription
            self.mentorGrowthCostLabel.text = "\(data.mentorGrowthCost) 성장 포인트"
            self.mentorLinkLabel.text = data.mentorLink
            self.nicknameLabel.text = data.nickname
            self.sexLabel.text = data.sex
            switch data.sex {
            case "MALE": self.sexLabel.text = "남자"
            case "FEMALE": self.sexLabel.text = "여자"
            default: self.sexLabel.text = "밝히지 않음"
            }
            
            var channelStr: String = ""
            switch data.isOnlineAvailable {
            case 1 : channelStr = "온라인 "
            default: channelStr = ""
            }
            
            switch data.isOnlineAvailable {
            case 1: channelStr += "오프라인"
            default: channelStr = channelStr + ""
            }
            self.channelLabel.text = channelStr
        }
    }
}
