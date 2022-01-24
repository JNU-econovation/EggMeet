//
//  HomeProfileVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/24.
//

import Foundation
import UIKit

class HomeProfileVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = ""
        self.navigationController?.navigationBar.isHidden =  false
    }
}
