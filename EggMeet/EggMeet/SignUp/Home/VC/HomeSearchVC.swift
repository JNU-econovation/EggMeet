//
//  HomeSearchVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/17.
//

import Foundation
import UIKit

class HomeSearchVC: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var searchKeyword: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = searchBar
        searchBar.placeholder = "닉네임 또는 프로필 키워드로 검색"
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            print("searchText \(searchBar.text!)")
        searchKeyword = searchBar.text ?? ""
        performSegue(withIdentifier: "unwindFromSearchVC", sender: self)
    }
}
