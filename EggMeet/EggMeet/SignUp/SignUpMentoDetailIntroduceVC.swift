//
//  SignUpMentoDetailIntroduceViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpMentoDetailIntroduceVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func windSignUpMentorAreaCareerView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentorAreaCareerVC") as? SignUpMentorAreaCareerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func skipAndWindSignUpMentorAreaCareerView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentorAreaCareerVC") as? SignUpMentorAreaCareerVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
