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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        let nibName = UINib(nibName: "HomeTVC", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
        attribute()
        
        getUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func attribute() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func windFilterVC(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeFilterVC") as! HomeFilterVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        
    }
    
    func getUserData(){
        HomeNetwork.shared.getHomeData()
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTVC
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "GrowthPointVC") as? GrowthPointVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        /*
        switch indexPath.row {
        case 0: self.performSegue(withIdentifier: "GrowthPointVC", sender: nil)
        case 1: self.performSegue(withIdentifier: "realTimeObjectDetection", sender: nil)
        case 2: self.performSegue(withIdentifier: "facialAnalysis", sender: nil)
        default:
            self.navigationController?.pushViewController("GrowthPointVC", animated: false)
            return
        }*/
    }
}
