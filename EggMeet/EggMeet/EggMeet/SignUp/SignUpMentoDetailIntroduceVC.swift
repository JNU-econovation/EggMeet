//
//  SignUpMentoDetailIntroduceViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpMentoDetailIntroduceVC: UIViewController{
    @IBOutlet weak var mentorIntroduceTextView: UITextView!
    @IBOutlet weak var textViewCountLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    let mentorIntroduceKey = "mentorDescription"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextViewStyle()
        mentorIntroduceTextView.layer.borderColor = UIColor.systemGray4.cgColor
        mentorIntroduceTextView.layer.cornerRadius = 10
        mentorIntroduceTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "멘토상세소개";
    }
    
    @IBAction func windSignUpMentorAreaCareerView(_ sender: Any){
        ud.set(mentorIntroduceTextView.text, forKey: mentorIntroduceKey)
        if mentorIntroduceTextView.text.count != 0 {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentorAreaCareerVC") as? SignUpMentorAreaCareerVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func skipAndWindSignUpMentorAreaCareerView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentorAreaCareerVC") as? SignUpMentorAreaCareerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func setTextViewStyle(){
        self.mentorIntroduceTextView.layer.borderWidth = 1.0
        self.mentorIntroduceTextView.layer.borderColor = UIColor.black.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mentorIntroduceTextView.endEditing(true)
        }
}

extension SignUpMentoDetailIntroduceVC : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.textViewCountLabel.text = "\(self.mentorIntroduceTextView.text.count)/500"
        if mentorIntroduceTextView.text.count != 0 {
            self.nextButton.setImage(UIImage(named: "enable_next_button"), for: .normal)
        } else {
            self.nextButton.setImage(UIImage(named: "next_button_disable"), for: .normal)
        }
        if mentorIntroduceTextView.text.count > 500{
            self.mentorIntroduceTextView.deleteBackward()
        }
    }
}
