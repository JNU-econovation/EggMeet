//
//  HomeUpperHeaderView.swift
//  EggMeet
//
//  Created by asong on 2022/01/10.
//

import Foundation
import UIKit

class HomeUpperHeaderView: UIView {
    let upperHeaderView = UIView()
    
    func setUp() {
        attribute()
        upperHeaderViewLayout()
    }
    
    func attribute() {
        upperHeaderView.backgroundColor = .yellow
    }
    
    func upperHeaderViewLayout(){
        upperHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            upperHeaderView.heightAnchor.constraint(equalToConstant: 80),
            upperHeaderView.widthAnchor.constraint(equalToConstant: 400)
        ])
    }
}
