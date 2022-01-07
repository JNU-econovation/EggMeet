//
//  SignUpSelfIntroduceViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpSelfIntroduceVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "자기 소개";
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func windSignUpMentoAreaSelectionView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoAreaSelectionVC") as? SignUpMentoAreaSelectionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpMentoAreaSelectionView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoAreaSelectionVC") as? SignUpMentoAreaSelectionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
