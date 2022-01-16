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
    
    private var homeList: [UserMentorResponseModel] = [UserMentorResponseModel]()
    private var isMentor: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        let nibName = UINib(nibName: "HomeTVC", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
        attribute()
        getHomeFirstData()
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
    
    @IBAction func touchFindMentorButton(_ sender: Any) {
        isMentor = true
        self.homeList.removeAll()
        HomeNetwork.shared.getUserMentorData(){ [self] mentorList in
            self.homeList.append(contentsOf: mentorList)
            self.tableView.reloadData()
        }
    }
    
    @IBAction func touchFindMenteeButton(_ sender: Any) {
        isMentor = false
        self.homeList.removeAll()
        HomeNetwork.shared.getUserMenteeData(){ [self] menteeList in
            self.homeList.append(contentsOf: menteeList)
            self.tableView.reloadData()
        }
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTVC
        let data = homeList[indexPath.row]
        cell.initCell(image: "data.pictureIndex", nickname: data.nickname, rating: data.mentorRating, mentorGrowthPoint: data.growthPoint, firstCategory: data.category, location: data.location, isOnline: data.onlineAvailable, isOffline : data.offlineAvailable, age: data.age, sex: data.sex, isMentor: isMentor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "GrowthPointVC") as? GrowthPointVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeVC {
    func getHomeFirstData(){
        HomeNetwork.shared.getUserMentorData(){ [self] mentorList in
            self.homeList.append(contentsOf: mentorList)
            self.tableView.reloadData()
        }
    }
}
