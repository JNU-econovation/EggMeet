//
//  HomeLowerHeaderView.swift
//  EggMeet
//
//  Created by asong on 2022/01/10.
//

import Foundation
import UIKit

class HomeLowerHeaderView: UIView {
    let lowerHeaderView = UIView()
    
    func setUp() {
        attribute()
        lowerHeaderViewLayout()
    }
    
    func attribute() {
        lowerHeaderView.backgroundColor = .gray
    }
    
    func lowerHeaderViewLayout(){
        lowerHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lowerHeaderView.heightAnchor.constraint(equalToConstant: 50),
            lowerHeaderView.widthAnchor.constraint(equalToConstant: 400)
        ])
    }
}
