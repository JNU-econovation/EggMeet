//
//  SignUpSetGrowthPointVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit

class SignUpSetGrowthPointVC : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windSignUpSetMenteeAreaCategoryView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaCategoryVC") as? SignUpSetMenteeAreaCategoryVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetMenteeAreaCategoryView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaCategoryVC") as? SignUpSetMenteeAreaCategoryVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
