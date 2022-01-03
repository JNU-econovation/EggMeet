//
//  SignUpCheckTermsOfServiceVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpCheckTermsOfServiceVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func windSignUpCheckTermsOfMaliciousContentView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfMaliciousContentVC") as? SignUpCheckTermsOfMaliciousContentVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
