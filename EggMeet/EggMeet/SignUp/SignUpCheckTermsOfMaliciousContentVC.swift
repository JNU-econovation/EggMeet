//
//  SignUpCheckTermsOfMaliciousContentVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpCheckTermsOfMaliciousContentVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windSignUpEndView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpEndVC") as? SignUpEndVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
