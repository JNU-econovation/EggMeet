//
//  NewMentoringScheduleSetVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/23.
//

import Foundation
import UIKit

class NewMentoringScheduleSetVC: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "신규 멘토링 등록";
        self.navigationController?.navigationBar.isHidden =  false
    }
}
