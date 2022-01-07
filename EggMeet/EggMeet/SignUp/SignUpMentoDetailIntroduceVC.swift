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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextViewStyle()
        self.navigationItem.title = "멘토 상세 소개";
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func windSignUpMentorAreaCareerView(_ sender: Any){
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
