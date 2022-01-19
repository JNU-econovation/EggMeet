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
    private var growthPointSort: String = ""
    private var location: String = ""
    private var category: String = ""
    var searchKeyword: String = ""
    private var sex: String = ""
    private var age: Int = 0
    private var isOnlineAvailable: Bool = true
    private var isOfflineAvailable: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        let nibName = UINib(nibName: "HomeTVC", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "HomeCell")
        attribute()
        getHomeMentorData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden =  true
    }
    
    private func attribute() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func windHomeSearchVC(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeSearchVC") as! HomeSearchVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        let filterVC = segue.source as! HomeFilterVC
        location = filterVC.location
        category = filterVC.category
        sex = filterVC.sex
        age = filterVC.age
        isOnlineAvailable = filterVC.isOnlineAvailable
        isOfflineAvailable = filterVC.isOfflineAvailable
        homeList.removeAll()
        switch isMentor {
        case true : getHomeMentorData()
        case false : getHomeMenteeData()
        }
    }
    
    @IBAction func unwindFromSearchVC(_ unwindSegue: UIStoryboardSegue) {
        let searchVC = unwindSegue.source as! HomeSearchVC
        searchKeyword = searchVC.searchKeyword
    }
    
    @IBAction func touchFindMentorButton(_ sender: Any) {
        isMentor = true
        self.homeList.removeAll()
        getHomeMentorData()
    }
    
    @IBAction func touchFindMenteeButton(_ sender: Any) {
        isMentor = false
        self.homeList.removeAll()
        getHomeMenteeData()
    }
    
    @IBAction func touchGrowthPointSortButton(_ sender: Any) {
        growthPointSort = "ASCENDING"
        self.homeList.removeAll()
        switch isMentor {
        case true : getHomeMentorData()
        case false : getHomeMenteeData()
        }
    }
    
    @IBAction func touchSortChangedButton(_ sender: Any) {
        switch growthPointSort {
        case "ASCENDING" : growthPointSort = "DESCENDING"
        case "DESCENDING" : growthPointSort = "ASCENDING"
        default : growthPointSort = ""
        }
        
        self.homeList.removeAll()
        switch isMentor {
        case true : getHomeMentorData()
        case false : getHomeMenteeData()
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
        cell.initCell(image: "data.pictureIndex", nickname: data.nickname, rating: data.mentorRating, mentorGrowthPoint: data.growthCost, firstCategory: data.category, location: data.location, isOnline: data.onlineAvailable, isOffline : data.offlineAvailable, age: data.age, sex: data.sex, isMentor: isMentor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "GrowthPointVC") as? GrowthPointVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension HomeVC {
    func getHomeMentorData(){
        HomeNetwork.shared.getUserMentorData(location: location, category: category, growthPointSort: growthPointSort, sex: sex, isOnlineAvailable: isOnlineAvailable, isOfflineAvailable: isOfflineAvailable, age: age){ [self] mentorList in
            self.homeList.append(contentsOf: mentorList)
            self.tableView.reloadData()
        }
    }
    
    func getHomeMenteeData() {
        HomeNetwork.shared.getUserMenteeData(location: location, category: category, sex: sex, isOnlineAvailable: isOnlineAvailable, isOfflineAvailable: isOfflineAvailable, age: age){ [self] menteeList in
            self.homeList.append(contentsOf: menteeList)
            self.tableView.reloadData()
        }
    }
}
