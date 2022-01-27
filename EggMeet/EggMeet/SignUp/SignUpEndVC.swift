//
//  SignUpEndVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpEndVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let registerUser = RegisterUser();
        registerUser.requestRegisterInformation()
    }
    
    
    @IBAction func goToMypageButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ToMyPage", sender: self)
    }
    
    @IBAction func windHomeButton(){
        let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC")
        self.navigationController?.hidesBottomBarWhenPushed = false
        self.navigationController?.pushViewController(vc, animated: true)
        //vc.hidesBottomBarWhenPushed = false
    }
}
