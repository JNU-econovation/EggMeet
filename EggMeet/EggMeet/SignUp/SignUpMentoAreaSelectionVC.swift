//
//  SignUpMentoAreaSelectionViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpMentoAreaSelectionVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func windSignUpMentoDetailIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoDetailIntroduceVC") as? SignUpMentoDetailIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    @IBAction func skipAndWindSignUpMentoDetailIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoDetailIntroduceVC") as? SignUpMentoDetailIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
