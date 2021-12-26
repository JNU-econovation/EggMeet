//
//  MainViewController.swift
//  EggMeet
//
//  Created by 이윤성 on 2021/12/26.
//
import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmailLabel.text = user?.email ?? ""
        detailsLabel.text = user?.debugDescription ?? ""
        print(user?.debugDescription ?? "none")
    }
}
