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
    @IBOutlet weak var filterLocationLabel: UILabel!
    @IBOutlet weak var filterCategoryLabel: UILabel!
    @IBOutlet weak var findMentorButton: UIButton!
    @IBOutlet weak var findMenteeButton: UIButton!
    
    private var homeList: [UserMentorResponseModel] = [UserMentorResponseModel]()
    private var isMentor: Bool = true
    private var growthPointSort: String = ""
    private var location: String = ""
    private var category: String = ""
    private var sex: String = ""
    private var age: Int = 0
    private var isOnlineAvailable: Bool? = nil
    private var isOfflineAvailable: Bool? = nil
    
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
        self.tableView.separatorColor = UIColor.clear
        
        self.view.bringSubviewToFront((self.tabBarController?.tabBar.plainView)!)
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
         category = "\(Category(rawValue: filterVC.category)!)"
        sex = filterVC.sex
        age = filterVC.age
        isOnlineAvailable = filterVC.isOnlineAvailable
        isOfflineAvailable = filterVC.isOfflineAvailable
        homeList.removeAll()
        switch isMentor {
        case true : getHomeMentorData()
        case false : getHomeMenteeData()
        }
        
        if category == "" {
            filterCategoryLabel.text = "전체"
        }else{
            filterCategoryLabel.text = filterVC.category
        }
        
        if location == "" {
            filterLocationLabel.text = "전체"
        }else{
            filterLocationLabel.text = location
        }
    }
    
    @IBAction func unwindFromSearchVC(_ unwindSegue: UIStoryboardSegue) {
        let searchVC = unwindSegue.source as! HomeSearchVC
        let searchKeyword = searchVC.searchKeyword
        print(searchKeyword)
        getSearchKeywordData(searchKeyword: searchKeyword)
    }
    
    @IBAction func touchFindMentorButton(_ sender: Any) {
        isMentor = true
        findMentorButton.setImage(UIImage(named: "home_find_mentor_selected"), for: .normal)
        findMenteeButton.setImage(UIImage(named: "home_find_mentee_deselected"), for: .normal)
        self.homeList.removeAll()
        getHomeMentorData()
    }
    
    @IBAction func touchFindMenteeButton(_ sender: Any) {
        isMentor = false
        findMentorButton.setImage(UIImage(named: "home_find_mentor_deselected"), for: .normal)
        findMenteeButton.setImage(UIImage(named: "home_find_mentee_selected"), for: .normal)
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
        cell.initCell(image: data.pictureIndex, nickname: data.nickname, rating: data.mentorRating, mentorGrowthPoint: data.growthCost, firstCategory: data.category, location: data.location, isOnline: data.onlineAvailable, isOffline : data.offlineAvailable, age: data.age, sex: data.sex, isMentor: isMentor)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeProfileVC") as? HomeProfileVC else {return}
        nextVC.id = homeList[indexPath.row].id
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
    
    func getSearchKeywordData(searchKeyword: String) {
        self.homeList.removeAll()
        switch isMentor {
        case true :
            HomeNetwork.shared.getSearchMentorKeywordData(keyword: searchKeyword){ [self] dataList in
                self.homeList.append(contentsOf: dataList)
                self.tableView.reloadData()
            }
        case false : HomeNetwork.shared.getSearchMenteeKeywordData(keyword: searchKeyword){ [self] dataList in
            self.homeList.append(contentsOf: dataList)
            self.tableView.reloadData()
        }
        }
    }
}
