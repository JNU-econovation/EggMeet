//
//  TotalScheduleVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/23.
//

import Foundation
import UIKit
import FSCalendar

class TotalScheduleVC: UIViewController {
    
    @IBOutlet weak var calendarView: FSCalendar!
    
    let dateFormatter = DateFormatter()
    var selectDateStr: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarView.appearance.headerDateFormat = "YYYY년 M월"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectDateStr = dateFormatter.string(from: Date())
    }
    
    @IBAction func touchDateSelectButton(_ sender: Any){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewMentorSelectPopUpVC") as! NewMentorSelectPopUpVC
        vc.selectedDateStr = selectDateStr
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}

extension TotalScheduleVC : FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 선택됨")
        selectDateStr = dateFormatter.string(from: date)
    }
    
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(dateFormatter.string(from: date) + " 해제됨")
    }
}


