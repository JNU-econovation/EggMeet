//
//  SignUpSetMenteeAreaDescriptionVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpSetMenteeAreaDescriptionVC : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windSignUpSetChannelView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetChannelVC") as? SignUpSetChannelVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetChannelView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetChannelVC") as? SignUpSetChannelVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
