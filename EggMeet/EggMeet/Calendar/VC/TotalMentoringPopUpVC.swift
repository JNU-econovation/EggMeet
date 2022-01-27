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
        let rootView = presentingViewController
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewMentoringScheduleSetVC") as! NewMentoringScheduleSetVC
        
        dismiss(animated:true) {
            //nextVC.navigationTitle = "멘토링 일정 변경"
            rootView?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @objc func dismissViewFromCancel(){
        let rootView = presentingViewController
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ScheduleCancelVC") as! ScheduleCancelVC
        
        dismiss(animated:true) {
            rootView?.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}

extension TotalMentoringPopUpVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! TotalMentoringTVC
        cell.nicknameLabel.text = cellData[indexPath.row]
        cell.editActionBlock = {
            print("touch 변경 버튼")
            self.dismissView()
        }
        cell.cancelActionBlick = {
            self.dismissViewFromCancel()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
