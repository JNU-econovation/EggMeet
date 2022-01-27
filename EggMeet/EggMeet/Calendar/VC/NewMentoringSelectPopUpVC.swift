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
    var selectedTimeStr = ""
    var selectedDateStr = ""
    var navigationTitle: String = ""
    var selectDate = Date()
    var newSchedule : Double = 0.0
    var mentoringId : Int = 0
   // var newSchedule : Double = 0.0
    //let newSchedule  = Int

    
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
    
    @IBAction func showAlert(_ sender: Any) {
        switch navigationTitle {
        case "신규 멘토링 등록" : showScheduleConfirmationAlert()
        case "멘토링 일정 변경" : showScheduleEditAlert()
        default : print("alert nothing")
        }
    }
    
    
    @IBAction func changeDatePicker(_ sender: UIDatePicker) {
        let datePickerView = sender // 전달된 인수 저장
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .none
        dateformatter.timeStyle = .short

        selectedTimeStr = dateformatter.string(from: datePickerView.date)
        
    }
    
    
    @IBAction func TimeSelect(_ sender: Any) {
        
        showScheduleConfirmationAlert()
        print (selectedTimeStr)
        print (selectDate)
        
        newSchedule = selectDate.timeIntervalSince1970
        NewMentoringScheduleSetNetwork.shared.postRequest(mentoringId: 22, newSchedule: newSchedule){ res in
            print("completion : mentoringId \(res)")
            self.dismissView()
        }
        print(newSchedule)
    }
    
    
    func showScheduleConfirmationAlert(){
        let alert = UIAlertController(title: selectedDateStr+selectedTimeStr,message: "이 일시로 멘토링 일정을 등록합니다. ",preferredStyle: UIAlertController.Style.alert)
        
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
        ////--------- 서버로 데이터 보내기
    }
    
   func showScheduleEditAlert(){
        let alert = UIAlertController(title: selectedDateStr + selectedTimeStr,message: "이 일시로 멘토링 일정을 수정합니다. ",preferredStyle: UIAlertController.Style.alert)
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


