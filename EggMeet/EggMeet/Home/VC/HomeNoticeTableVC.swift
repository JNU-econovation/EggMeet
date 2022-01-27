//
//  HomeNoticeTableVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/18.
//

import Foundation
import UIKit

class HomeNoticeTableVC: UIViewController{
    @IBOutlet weak var tableView: UITableView!
    
    var noticeArr: [String] = ["yunseong님으로부터 새로운 메시지가 도착했습니다."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: "HomeNoticeTVC", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "NoticeCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension HomeNoticeTableVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeArr.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoticeCell", for: indexPath) as! HomeNoticeTVC
        cell.noticeLabel.text = noticeArr[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
    // 테이블뷰 셀 옆으로 스와이프해서 삭제
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            noticeArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "Chat", bundle: nil)
        guard let nextVC = storyboard.instantiateViewController(withIdentifier: "ChatroomVC") as? ChatroomVC else {return}
        nextVC.chatroomID = 26
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
