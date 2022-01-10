//
//  HomeHeaderView.swift
//  EggMeet
//
//  Created by asong on 2022/01/10.
//

import Foundation
import UIKit

class HomeHeaderView: UIView {
    let tableHeaderView = UIView()
    
    func setUp() {
        attribute()
        headerViewLayout()
    }
    
    func attribute() {
        tableHeaderView.backgroundColor = .brown
    }
    
    func headerViewLayout(){
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
    }
}
