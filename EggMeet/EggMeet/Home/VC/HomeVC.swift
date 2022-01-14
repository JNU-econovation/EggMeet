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
    
    private var homeList: [HomeResponseModel] = [HomeResponseModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        let nibName = UINib(nibName: "HomeTVC", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
        attribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        //getUserData()
        testDataSet()
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

    func testDataSet(){
        homeList.append(contentsOf: [
            HomeResponseModel.init(age: 20, description: "hi", location: .ALL, menteeCategory: .PROGRAMMING_C, menteeDescription: "happy", menteeRating: 4.5, mentorCareer: "hi", mentorDescription: "hi", mentorGrowthPoint: 3, mentorLink: "http", mentorRating: 4.3, nickname: "songa", isOfflineAvailable: true, isOnlineAvailable: true, pictureIndex: 2, sex: .FEMALE),
            HomeResponseModel.init(age: 20, description: "hi", location: .ALL, menteeCategory: .PROGRAMMING_C, menteeDescription: "happy", menteeRating: 4.5, mentorCareer: "hi", mentorDescription: "hi", mentorGrowthPoint: 3, mentorLink: "http", mentorRating: 4.3, nickname: "yunseong", isOfflineAvailable: true, isOnlineAvailable: false, pictureIndex: 2, sex: .MALE),
            HomeResponseModel.init(age: 20, description: "hi", location: .ALL, menteeCategory: .PROGRAMMING_C, menteeDescription: "happy", menteeRating: 4.5, mentorCareer: "hi", mentorDescription: "hi", mentorGrowthPoint: 3, mentorLink: "http", mentorRating: 4.3, nickname: "hyunji", isOfflineAvailable: true, isOnlineAvailable: true, pictureIndex: 2, sex: .UNDEFINED)
        ])
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
        cell.initCell(image: "data.pictureIndex", nickname: data.nickname, rating: "data.mentorRating", mentorGrowthPoint: data.mentorGrowthPoint, firstCategory: data.menteeCategory, location: data.location, isOnline: data.isOnlineAvailable, age: data.age, sex: data.sex)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "GrowthPointVC") as? GrowthPointVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeVC {
    func getUserData(){
        HomeNetwork.shared.getHomeData()
    }
}
