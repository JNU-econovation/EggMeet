//
//  SignUpNickName.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit

class SignUpNickNameVC: UIViewController {
    @IBOutlet weak var nicknameTextField: UITextField!
    let nicknameKey = "nickname"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "닉네임";
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    @IBAction func windSignUpLocationView(_ sender: Any){
        ud.set(self.nicknameTextField.text, forKey: nicknameKey)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpLocationVC") as? SignUpLocationVC else {return}
        print("실행")
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
    
}
