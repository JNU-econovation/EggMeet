//
//  SeeMyProfileVC.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/24.
//

import UIKit

class SeeMyProfileVC: UIViewController {

  
 
    @IBOutlet weak var SeeMyProfileImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // userimage를 원형으로 crop
        SeeMyProfileImage.layer.cornerRadius = SeeMyProfileImage.frame.height/2
        SeeMyProfileImage.layer.borderWidth = 1
        SeeMyProfileImage.clipsToBounds = true
        SeeMyProfileImage.layer.borderColor = UIColor.clear.cgColor
        //원형 이미지의 테두리 제거

       
    }
    
  

}
