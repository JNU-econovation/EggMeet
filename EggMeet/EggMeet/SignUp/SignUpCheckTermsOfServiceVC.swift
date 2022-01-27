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
    @IBOutlet weak var nextButton: UIButton!
    
    var isAgreeTermsOfService = false
    var isAgreePersonalInfo = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func touchUpAgreeTermsOfServiceButton(_ sender: UIButton){
        isAgreeTermsOfService = !isAgreeTermsOfService
        sender.isSelected.toggle()
    }
    
    @IBAction func touchUpAgreePersonalInfoButton(_ sender: UIButton){
        isAgreePersonalInfo = !isAgreePersonalInfo
        sender.isSelected.toggle()
    }
    
    @IBAction func windSignUpCheckTermsOfMaliciousContentView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpCheckTermsOfMaliciousContentVC") as? SignUpCheckTermsOfMaliciousContentVC else {return}
        if (isAgreePersonalInfo && isAgreeTermsOfService) == true {
            self.nextButton.setImage(UIImage(named: "enable_next_button"), for: .normal)
            self.navigationController?.pushViewController(nextVC, animated: true)

        } else {
            checkAlert()
            print("둘 다 동의해주세요!")
            return
        }
     }
    
    @IBAction func windSignUpShowPersonalInfoView(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpShowPersonalInfoVC") as? SignUpShowPersonalInfoVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func windSignUpShowTermsOfServiceVC(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpShowTermsOfServiceVC") as? SignUpShowTermsOfServiceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func checkAlert(){
        let alert = UIAlertController(title: "약관 동의", message: "모두 동의해주세요.", preferredStyle: UIAlertController.Style.alert)
        let cancelButton = UIAlertAction(title: "확인", style: .default , handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
}
