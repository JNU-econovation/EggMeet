//
//  SignUpSetMenteeAreaCategoryVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpSetMenteeAreaCategoryVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windSignUpSetMenteeAreaDescriptionView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaDescriptionVC") as? SignUpSetMenteeAreaDescriptionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetMenteeAreaDescriptionView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaDescriptionVC") as? SignUpSetMenteeAreaDescriptionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
