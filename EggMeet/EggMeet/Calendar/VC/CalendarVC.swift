//
//  CalendarVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/22.
//

import Foundation
import UIKit
import Tabman
import Pageboy

class CalendarVC: TabmanViewController {
   // @IBOutlet weak var titleLabel: UILabel!
    
    var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableVC = UIStoryboard.init(name: "CalendarStoryboard", bundle: nil).instantiateViewController(withIdentifier: "TotalScheduleVC") as! TotalScheduleVC
        let tableVC2 = UIStoryboard.init(name: "CalendarStoryboard", bundle: nil).instantiateViewController(withIdentifier: "PartnerScheduleVC") as! PartnerScheduleVC
        let tableVC3 = UIStoryboard.init(name: "CalendarStoryboard", bundle: nil).instantiateViewController(withIdentifier: "NewMentoringRegisterVC") as! NewMentoringRegisterVC
        let tableVC4 = UIStoryboard.init(name: "CalendarStoryboard", bundle: nil).instantiateViewController(withIdentifier: "MyMeetReviewVC") as! MyMeetReviewVC
        viewControllers.append(tableVC)
        viewControllers.append(tableVC2)
        viewControllers.append(tableVC3)
        viewControllers.append(tableVC4)
        
        self.dataSource = self
       
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
        
        //self.view.bringSubviewToFront(titleLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .none
        
        
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 80, left: 12.0, bottom: 0.0, right: 12.0)
        
        // 간격
        ctBar.layout.interButtonSpacing = 15
        ctBar.backgroundColor = .clear
        ctBar.backgroundView.style = .clear
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = UIColor(red: 1, green: 0.706, blue: 0, alpha: 1)
            button.font = UIFont(name: "Apple SD 산돌고딕 Neo 볼드체", size: 15) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
            button.selectedFont = UIFont(name: "Apple SD 산돌고딕 Neo 볼드체", size: 15) ?? UIFont.systemFont(ofSize: 12, weight: .regular)
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 5)
        ctBar.indicator.tintColor = UIColor(red: 1, green: 0.706, blue: 0, alpha: 1)
    }
}
extension CalendarVC: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
   
        // MARK: -Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: "전체 일정 보기")
        case 1:
            return TMBarItem(title: "파트너별 일정 보기")
        case 2:
            return TMBarItem(title: "신규 멘토링 등록")
        case 3:
            return TMBarItem(title: "나의 만남후기")
        default:
            let title = "Page \(index)"
            return TMBarItem(title: title)
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        //위에서 선언한 vc array의 count를 반환합니다.
        return viewControllers.count
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        print("index : \(index)")
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}


