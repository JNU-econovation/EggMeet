//
//  SignUpMentorAreaCareerVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpMentorAreaCareerVC : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var mentorAreaCareerTextField: UITextView!
    
    let ud = UserDefaults.standard
    let mentorAreaCareerKey: String = "mentorAreaCareer"
    
    override func viewDidLoad() {
        buildTextViewStyle()
        super.viewDidLoad()
    }
    
    // 화면 터치시 키보드 내려감.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.mentorAreaCareerTextField.resignFirstResponder()
        }

    @IBAction func windSignUpSetGrowthPointView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetGrowthPointVC") as? SignUpSetGrowthPointVC else {return}
        ud.set(self.mentorAreaCareerTextField.text, forKey: mentorAreaCareerKey)
        print(ud.value(forKey: mentorAreaCareerKey))
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetGrowthPointView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetGrowthPointVC") as? SignUpSetGrowthPointVC else {return}
        self.mentorAreaCareerTextField.text = ""
        ud.set("", forKey: mentorAreaCareerKey)
        print(ud.value(forKey: mentorAreaCareerKey))
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func buildTextViewStyle(){
        self.mentorAreaCareerTextField.layer.borderWidth = 1.0
        self.mentorAreaCareerTextField.layer.borderColor = UIColor.black.cgColor
    }
}
