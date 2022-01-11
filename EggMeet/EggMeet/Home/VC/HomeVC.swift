//
//  HomeVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/10.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let headerView = HomeHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "HomeTVC", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setUp() {
        attribute()
        layout()
    }
    
    private func attribute() {
        tableView.delegate = self
        tableView.dataSource = self
        

        tableView.tableHeaderView = headerView.tableHeaderView
        headerView.setUp()
        updateHederViewLayout()
    }
    
    private func layout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func updateHederViewLayout() {
        headerView.stackView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 130)
        tableView.tableHeaderView = headerView.stackView
        tableView.layoutIfNeeded()
    }
}

extension HomeVC: UITableViewDelegate {

}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTVC

            return cell
   }
}
