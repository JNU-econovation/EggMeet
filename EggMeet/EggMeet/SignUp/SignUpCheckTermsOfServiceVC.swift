//
//  SignUpCheckTermsOfServiceVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpCheckTermsOfServiceVC: UIViewController {
    
    @IBOutlet weak var termsOfServiceCheckButton: UIButton!
    @IBOutlet weak var personalInfocheckButton: UIButton!
    
    var isAgreeTermsOfService = false
    var isAgreePersonalInfo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpAgreeTermsOfServiceButton(_ sender: UIButton){
        isAgreeTermsOfService = !isAgreeTermsOfService
        if isAgreeTermsOfService {
            sender.setTitle("체크 됨", for: .normal)
        } else {
            sender.setTitle("체크 안됨", for: .normal)
        }
    }
    
    @IBAction func touchUpAgreePersonalInfoButton(_ sender: UIButton){
        isAgreePersonalInfo = !isAgreePersonalInfo
        if isAgreePersonalInfo {
            sender.setTitle("체크 됨", for: .normal)
        } else {
            sender.setTitle("체크 안됨", for: .normal)
        }
    }
    
    @IBAction func windSignUpCheckTermsOfMaliciousContentView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfMaliciousContentVC") as? SignUpCheckTermsOfMaliciousContentVC else {return}
        if (isAgreePersonalInfo && isAgreeTermsOfService) == true {
            self.navigationController?.pushViewController(nextVC, animated: true)

        } else {
            print("둘 다 동의해주세요!")
            return
        }
     }
}
