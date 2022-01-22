//
//  LocationCollectionViewCell.swift
//  EggMeet
//
//  Created by asong on 2022/01/22.
//

import Foundation
import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    @IBOutlet var locationLabel: UILabel!
    override var isSelected: Bool{
        didSet {
            if isSelected {
                locationLabel.textColor = .black
                self.layer.borderColor = UIColor.black.cgColor
                locationLabel.font = UIFont.boldSystemFont(ofSize: 10)
            } else {
                locationLabel.textColor = .gray
                self.layer.borderColor = UIColor.gray.cgColor
                locationLabel.font = UIFont.systemFont(ofSize: 10)
            }
        }
    }
}
