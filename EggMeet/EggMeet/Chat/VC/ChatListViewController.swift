//
//  ChatListViewController.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/10.
//

import Foundation
import UIKit

class ChatListViewController: UITableViewController {
    
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
        
        let nickname = cell.viewWithTag(100) as? UILabel
        let lastestDate = cell.viewWithTag(101) as? UILabel
        let description = cell.viewWithTag(102) as? UILabel
        
        nickname?.text = row.nickname
        lastestDate?.text = row.lastestDate
        description?.text = row.description
        
        return cell
    }
    
    // 사용자가 행을 선택했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("select Row : \(indexPath.row)")
        
    }
    
}
