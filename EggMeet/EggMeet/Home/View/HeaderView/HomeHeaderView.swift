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
    let upperHeaderView = HomeUpperHeaderView()
    let lowerHeaderView = HomeLowerHeaderView()
    var stackView : UIStackView!
    
    func setUp() {
        attribute()
        headerViewLayout()
    }
    
    func attribute() {
        tableHeaderView.backgroundColor = .brown
    }
    
    func headerViewLayout(){
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        upperHeaderView.setUp()
        lowerHeaderView.setUp()
        setStackView()
        //tableHeaderView.addSubview(stackView)
    }
    
    func setStackView() {
        self.stackView = UIStackView()
        self.stackView.axis = .vertical
        self.stackView.alignment = .fill
        self.stackView.distribution = .fillEqually
        self.stackView.spacing = 0
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.addArrangedSubview(upperHeaderView.upperHeaderView)
        self.stackView.addArrangedSubview(lowerHeaderView.lowerHeaderView)
        
        print("stackview 추가")
        NSLayoutConstraint.activate([
            self.stackView.heightAnchor.constraint(equalToConstant: 200) ,
            self.stackView.widthAnchor.constraint(equalToConstant: 300)
           ])
    }
}
