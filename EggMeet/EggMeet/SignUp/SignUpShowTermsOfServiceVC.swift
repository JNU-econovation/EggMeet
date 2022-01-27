//
//  SignUpShowTermsOfServiceVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/09.
//

import Foundation
import UIKit

class SignUpShowTermsOfServiceVC: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
}
