//
//  NewMentoringSelectPopUpVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/23.
//

import Foundation
import UIKit

class NewMentorSelectPopUpVC: UIViewController {
    @IBOutlet weak var timeSelectButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    var selectedDateStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dateLabel.text = selectedDateStr
    }
    
    @objc func dismissView(){
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func showScheduleConfirmationAlert(_ sender: Any){
        let alert = UIAlertController(title: selectedDateStr,message: "이 일시로 멘토링 일정을 등록합니다. ",preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "취소", style: .default, handler: nil)
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "확인", style: .destructive, handler: {
            action in
            //특정기능 수행
            self.dismissView()
        })
        alert.addAction(cancel)
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
