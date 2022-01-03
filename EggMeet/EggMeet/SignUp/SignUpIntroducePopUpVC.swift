//
//  SignUpIntroducePopUpView.swift
//  EggMeet
//
//  Created by asong on 2022/01/02.
//

import Foundation
import UIKit

class SignUpIntroducePopUpVC: UIViewController {

    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closeButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func dismissView(){
        dismiss(animated: false, completion: nil)
    }

}
