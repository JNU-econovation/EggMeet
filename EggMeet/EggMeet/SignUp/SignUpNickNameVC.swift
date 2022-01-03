//
//  SignUpNickName.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpNickNameVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func windSignUpLocationView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpLocationVC") as? SignUpLocationVC else {return}
        print("실행")
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
