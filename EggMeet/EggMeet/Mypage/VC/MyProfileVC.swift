//
//  MyProfileVC.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/22.
//

import UIKit

class MyProfileVC: UIViewController {

    @IBOutlet weak var MyProfileImage: UIImageView!
    
    
    @IBOutlet weak var MyProfileNickname: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyProfileNickname.adjustsFontSizeToFitWidth = true
        // userimage를 원형으로 crop
        MyProfileImage.layer.cornerRadius = MyProfileImage.frame.height/2
        MyProfileImage.layer.borderWidth = 1
        MyProfileImage.clipsToBounds = true
        MyProfileImage.layer.borderColor = UIColor.clear.cgColor
        //원형 이미지의 테두리 제거
        setProfileData()
    }
    
    func setProfileData(){
        MypageNetwork.shared.getMypageData() { data in
            
            self.MyProfileNickname.text = data.nickname
            
            }
            
           
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
