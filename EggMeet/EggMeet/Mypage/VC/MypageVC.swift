//
//  MypageVC.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/21.
//

import UIKit

class MypageVC: UIViewController {

    @IBOutlet weak var myNameTail: UILabel!
    @IBOutlet weak var myName: UILabel!
    @IBOutlet weak var myProfileBackground: UILabel!
    @IBOutlet weak var myProfileImage: UIImageView!
    @IBOutlet weak var mypageTitleLabel: UILabel!
    
    @IBOutlet weak var myPossessionLabel: UILabel!
    @IBOutlet weak var myPossessPoint: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var myGrowthStageLabel: UILabel!
    @IBOutlet weak var myGrowthStageImage: UIImageView!
    
    @IBOutlet weak var myPossessPointBackgrounc: UILabel!
    
    override func viewDidLoad() {

        // 뷰가 메모리에 로드되고, 화면에 뜨기 수행해야할 추가적인 작업
        super.viewDidLoad()
        //라벨이 텍스트에 fit하게
        mypageTitleLabel.adjustsFontSizeToFitWidth = true
        myName.adjustsFontSizeToFitWidth = true
        myNameTail.adjustsFontSizeToFitWidth = true
        myPossessionLabel.adjustsFontSizeToFitWidth = true
        myPossessPoint.adjustsFontSizeToFitWidth = true
        pointLabel.adjustsFontSizeToFitWidth = true
        myGrowthStageLabel.adjustsFontSizeToFitWidth = true
        
        //프로필 이미지 원형으로 crop
        myProfileImage.layer.cornerRadius = myProfileImage.frame.height/2
        myProfileImage.layer.borderWidth = 1
        myProfileImage.clipsToBounds = true
        myProfileImage.layer.borderColor = UIColor.clear.cgColor
        
       
    }
    
    @IBAction func toGrowthStageInfo(_ sender: Any) {
    }
    @IBAction func toMyProfileButton(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
