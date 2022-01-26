//
//  HomeProfileRequestPopUpVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/26.
//

import Foundation
import UIKit

class HomeProfileRequestPopUpVC: UIViewController {
    @IBOutlet weak var closeButton: UIButton!
    
    var requestMentorNickname: String = ""
    var mentorId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func dismissView(roomId: String){
        let rootView = presentingViewController
        let chatStoryboard = UIStoryboard(name: "Chat", bundle: nil)
        let nextVC = chatStoryboard.instantiateViewController(withIdentifier: "ChatroomVC") as! ChatroomVC
        
        dismiss(animated:true) {
            nextVC.chatroomID = Int(roomId)!
            nextVC.modalPresentationStyle = .fullScreen
            rootView?.present(nextVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func showMentorRequestAlert(){
        let alert = UIAlertController(title: "\(requestMentorNickname)님께 멘토 신청을 하시겠습니까?",message: " ",preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "확인", style: .default, handler: {
            action in
            self.postRequest()
        })
        alert.addAction(cancel)
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
    
    @IBAction func touchCloseButton(){
        dismiss(animated: true, completion: nil)
    }
    
    func postRequest(){
        HomeNetwork.shared.postRequest(mentorId: mentorId) { roomId in
            print("completion : roomID \(roomId)")
            self.dismissView(roomId: roomId)
        }
    }
}
