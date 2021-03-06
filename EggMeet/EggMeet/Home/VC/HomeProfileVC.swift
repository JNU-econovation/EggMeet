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
    @IBOutlet weak var imageView: UIImageView!
    
    var id: Int = 0
    var requestNickname: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "상세 프로필"
        self.navigationController?.navigationBar.isHidden =  false
        nicknameLabel.adjustsFontSizeToFitWidth = true
        setNavigationBarRightItem()
        setProfileData()
    }
    
    func setNavigationBarRightItem(){
        let moreButton = UIButton(frame: CGRect(x: 0, y: 0, width: 4.3, height: 18.7))
        moreButton.setBackgroundImage(UIImage(named: "setting"), for: .normal)
        moreButton.addTarget(self, action: #selector(self.showAccuseButtons), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem(customView: moreButton)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 18.7).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 5).isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    @objc func showAccuseButtons(){
        print("show accuse button")
        let alert = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "신고하기", style: .destructive, handler: { action in
            // 신고 로직 작성
        }))
        alert.addAction(UIAlertAction(title: "차단하기", style: .destructive, handler: { action in
            // 차단 로직 작성
        }))
        alert.addAction(UIAlertAction(title: "만남후기 작성", style: . default, handler: { action in
            // 만남 후기 작성 로직 추가
        }))

        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func setProfileData(){
        HomeNetwork.shared.getUserProfileData(id: id) { data in
            self.nicknameLabel.text = data.nickname
            self.ageLabel.text = "\(data.age)대"
            self.descriptionLabel.text = data.description
            self.locationLabel.text = "광주광역시 북구"
            self.menteeCategoryLabel.text = data.menteeCategory
            self.menteeDescriptionLabel.text = data.menteeDescription
            self.mentorCareerLabel.text = data.mentorCareer
            self.mentorCategoryLabel.text = data.mentorCategory
            self.mentorDescriptionLabel.text = data.mentorDescription
            self.mentorGrowthCostLabel.text = "\(data.mentorGrowthCost)포인트"
            let imageList = ["origin_egg", "gold_egg","brown_egg"]
            self.imageView.image = UIImage(named: imageList[data.pictureIndex])
            
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
            
            self.requestNickname = data.nickname
        }
    }
    
    @IBAction func touchRequestButton(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeProfileRequestPopUpVC") as! HomeProfileRequestPopUpVC
        vc.requestMentorNickname = requestNickname
        vc.mentorId = id
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}
