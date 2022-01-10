//
//  HomeVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/10.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "";
    }
    
    @IBAction func moveToGrowthPoint(_ sender: UIButton){
        tabBarController?.selectedIndex = 1
    }
}
