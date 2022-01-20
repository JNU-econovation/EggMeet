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
    let mentorIntroduceKey = "mentorDescription"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextViewStyle()
        self.navigationItem.title = "멘토 상세 소개";
        self.navigationController?.navigationBar.tintColor = .black
        mentorIntroduceTextView.layer.borderColor = UIColor.systemGray4.cgColor
        mentorIntroduceTextView.layer.cornerRadius = 10
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func windSignUpMentorAreaCareerView(_ sender: Any){
        ud.set(mentorIntroduceTextView.text, forKey: mentorIntroduceKey)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentorAreaCareerVC") as? SignUpMentorAreaCareerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
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
