//
//  SignUpSetChannelVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpSetChannelVC : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func windSignUpCheckTermsOfServiceView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfServiceVC") as? SignUpCheckTermsOfServiceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpCheckTermsOfServiceView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfServiceVC") as? SignUpCheckTermsOfServiceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
