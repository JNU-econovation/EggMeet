//
//  ChatListViewController.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/10.
//

import Foundation
import UIKit
import Alamofire

let NICKNAME_CELL_TAG = 100
let LASTEST_DATE_CELL_TAG = 101
let DESCRIPTION_CELL_TAG = 102

class ChatListVC: UITableViewController {
    
    var chatListDictionary: [ChatListDto] = [ChatListDto]()
    
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
        
        AF.request(request).responseData{(DataResponse) in
            switch DataResponse.result {
            case .success(let value):
                do {
                    
                    let dataList = try JSONSerialization.jsonObject(with: value, options: []) as! [[String: Any]]
                    for data in dataList{
                        let id: Int = data["id"] as! Int
                        let participantNickname: String = data["participantNickname"] as! String
                        let recentMessageContent: String? = data["recentMessageContent"] as? String
                        
                        let dataContent: ChatListDto = ChatListDto(id: id, participantNickname: participantNickname, recentMessageContent: recentMessageContent ?? "")
                        
                        NSLog("data content: \(dataContent)")
                        self.chatListDictionary.append(dataContent)
                        
                        self.tableView.reloadSections(IndexSet(0...0), with: UITableView.RowAnimation.automatic)
                    }
                } catch{print(error.localizedDescription)}
            case .failure(let error):
                NSLog("load error : \(error)")
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyChatList()
    }
    
    // 행 갯수 반환하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatListDictionary.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.chatListDictionary[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell")!
        
        let nickname = cell.viewWithTag(NICKNAME_CELL_TAG) as? UILabel
        let description = cell.viewWithTag(DESCRIPTION_CELL_TAG) as? UILabel
        
        nickname?.text = row.participantNickname
        description?.text = row.recentMessageContent
    
        return cell
    }

    // 사용자가 행을 선택했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.chatListDictionary[indexPath.row]
        NSLog("select Row : \(indexPath.row)")
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatroomVC") as? ChatroomVC else {return}
        nextVC.opponentNickname = row.participantNickname
        nextVC.chatroomID = row.id
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChatroomSegue" {
            let vc = segue.destination as? ChatroomVC
            if let participantNickname = sender as? String {
                vc?.opponentNickname = participantNickname
            }
            if let chatroomId = sender as? Int {
                vc?.chatroomID = chatroomId
                NSLog("receive chatroom Id : \(chatroomId)")
            }
        }
    }
}
