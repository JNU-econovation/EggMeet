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

        let bgView: UIImageView = UIImageView(image: UIImage(named: "tabbar_transparent"))
        //let bgView: UIImageView = UIImageView(image: UIImage(named: "tabbar_image"))
        
        //bgView.frame = CGRect(x: 0, y: tabBar.center.y - 76, width: 375, height:76)
        //bgView.tintColor = .clear
       // self.view.addSubview(bgView)
        self.tabBar.layer.masksToBounds = true
        self.tabBar.isTranslucent = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.borderWidth = 0.5
        self.tabBar.layer.borderColor = CGColor(red: 191/255, green: 191/255, blue: 191/255, alpha: 1)
        self.tabBar.tintColor = UIColor(red: 255/255, green: 180/255, blue: 0, alpha: 1)
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
