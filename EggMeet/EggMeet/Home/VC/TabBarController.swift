//
//  TabBarController.swift
//  EggMeet
//
//  Created by asong on 2022/01/27.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        var bgView: UIImageView = UIImageView(image: UIImage(named: "tabbar_image"))
        
        bgView.frame = CGRect(x: 0, y: tabBar.center.y - 76, width: 375, height:76)
        bgView.tintColor = .clear
        //self.view.addSubview(bgView)
    }
}
