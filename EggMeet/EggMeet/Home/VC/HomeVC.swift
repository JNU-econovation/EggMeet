//
//  HomeVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/10.
//

import Foundation
import UIKit

class HomeVC: UIViewController {
    
    private let tableView = UITableView()
    private let headerView = HomeHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        headerView.tableHeaderView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        tableView.tableHeaderView = headerView.tableHeaderView
        tableView.layoutIfNeeded()
        
        self.view.addSubview(headerView.stackView)
        headerView.stackView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30).isActive = true
        headerView.stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.view.bottomAnchor.constraint(equalTo: headerView.stackView.bottomAnchor).isActive = true
        self.view.trailingAnchor.constraint(equalTo: headerView.stackView.trailingAnchor).isActive = true
    }
}

extension HomeVC: UITableViewDelegate {

}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell()
      cell.textLabel?.text = "\(indexPath.row)"
      return cell
    }
}
