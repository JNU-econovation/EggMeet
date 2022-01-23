//
//  TotalMentoringPopUpVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/23.
//

import Foundation
import UIKit

class TotalMentoringPopUpVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
   
    var selectedDateStr = ""
    let cellData: [String] = ["송아", "지우"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func dismissView(){
        dismiss(animated:true, completion: nil)
    }
}

extension TotalMentoringPopUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! TotalMentoringTVC
        cell.nicknameLabel.text = cellData[indexPath.row]
        
        return cell
    }
}
