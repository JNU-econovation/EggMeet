//
//  SignUpMentorAreaCareerVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpMentorAreaCareerVC : UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var mentorAreaCareerTextView: UITextView!
    @IBOutlet var explainLabel: UILabel!
    @IBOutlet var textViewCountLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    let ud = UserDefaults.standard
    let mentorAreaCareerKey: String = "mentorAreaCareer"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTextViewStyle()
        mentorAreaCareerTextView.delegate = self
    }
    
    // 화면 터치시 키보드 내려감.

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.mentorAreaCareerTextView.resignFirstResponder()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        textViewCountLabel.text = "\(mentorAreaCareerTextView.text.count)/500"
    }

    @IBAction func windSignUpSetGrowthPointView(_ sender: Any){
        if self.mentorAreaCareerTextView.text == "" {
            showAlert()
            return
        }
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetGrowthPointVC") as? SignUpSetGrowthPointVC else {return}
        ud.set(self.mentorAreaCareerTextView.text, forKey: mentorAreaCareerKey)
        print(ud.value(forKey: mentorAreaCareerKey))
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetGrowthPointView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetGrowthPointVC") as? SignUpSetGrowthPointVC else {return}
        self.mentorAreaCareerTextView.text = ""
        ud.set("", forKey: mentorAreaCareerKey)
        print(ud.value(forKey: mentorAreaCareerKey))
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func buildTextViewStyle(){
        self.mentorAreaCareerTextView.layer.borderWidth = 1.0
        self.mentorAreaCareerTextView.layer.borderColor = UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor
        self.mentorAreaCareerTextView.layer.cornerRadius = 12
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "주의", message: "내용을 작성해주세요!", preferredStyle: UIAlertController.Style.alert)
        let cancelButton = UIAlertAction(title: "확인", style: .default , handler: nil)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
}

extension SignUpMentorAreaCareerVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textViewCountLabel.text = "\(self.mentorAreaCareerTextView.text.count)/500"
        if mentorAreaCareerTextView.text.count != 0 {
            // enable image
            let enableImage = UIImage(named: "enable_next_button")
            self.nextButton.setImage(enableImage, for: .normal)
        } else {
            // disable image
            let disableImage = UIImage(named: "next_button_disable")
            self.nextButton.setImage(disableImage, for: .normal)
        }
        if mentorAreaCareerTextView.text.count > 500{
            self.mentorAreaCareerTextView.deleteBackward()
        }
    }
}
