//
//  SignUpLocationViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpLocationVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windSignUpSelfIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("다음으로")
    }
    @IBAction func skipAndWindSignUpSelfIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("건너뛰기")
    }
}
