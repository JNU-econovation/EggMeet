//
//  ChatListViewController.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/10.
//

import Foundation
import UIKit

let NICKNAME_CELL_TAG = 100
let LASTEST_DATE_CELL_TAG = 101
let DESCRIPTION_CELL_TAG = 102

class ChatListVC: UITableViewController {
    
    var testDataset = [
            ("이윤성", "11:10", "test description 1"),
            ("권순찬", "어제", "test description 2"),
            ("류현지", "모래", "test description 3"),
            ("김송아", "3일 전", "test description 4"),
            ("황지우", "한 달전", "test description 5")
        ]
    
    lazy var testList:[ChatProfileVO] = {
        var testDataList = [ChatProfileVO]()
        for(nickname, lastestDate, description) in self.testDataset {
            let cpvo = ChatProfileVO()
            cpvo.nickname = nickname
            cpvo.lastestDate = lastestDate
            cpvo.description = description
            
            testDataList.append(cpvo)
        }
        return testDataList
    }()
    
    func getMyChatList(){
        let ud = UserDefaults.standard
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://" + mainAddress + "/chat/room"
        var request = URLRequest(url: URL(string: apiURL)!)
        let accessToken = ud.string(forKey: "accessToken")!
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 행 갯수 반환하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.testList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell")!
        
        let nickname = cell.viewWithTag(NICKNAME_CELL_TAG) as? UILabel
        let lastestDate = cell.viewWithTag(LASTEST_DATE_CELL_TAG) as? UILabel
        let description = cell.viewWithTag(DESCRIPTION_CELL_TAG) as? UILabel
        
        nickname?.text = row.nickname
        lastestDate?.text = row.lastestDate
        description?.text = row.description
        
        return cell
    }

    // 사용자가 행을 선택했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.testList[indexPath.row]
        NSLog("select Row : \(indexPath.row)")
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatroomVC") as? ChatroomVC else {return}
        nextVC.opponentNickname = row.nickname
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatroomSegue" {
            let vc = segue.destination as? ChatroomVC
            if let nickname = sender as? String {
                vc?.opponentNickname = nickname
            }
        }
    }
}
