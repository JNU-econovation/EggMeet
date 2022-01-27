//
//  HomeNoticeVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/17.
//

import Foundation
import UIKit
import Tabman
import Pageboy

class HomeNoticeVC: TabmanViewController {
    
    var viewControllers: Array<UIViewController> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "알림";
        self.navigationController?.navigationBar.topItem?.title = ""
        
        let tableVC = UIStoryboard.init(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeNoticeTableVC") as! HomeNoticeTableVC
        let tableVC2 = UIStoryboard.init(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeNoticeTableVC") as! HomeNoticeTableVC
        let tableVC3 = UIStoryboard.init(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeNoticeTableVC") as! HomeNoticeTableVC
        let tableVC4 = UIStoryboard.init(name: "HomeStoryboard", bundle: nil).instantiateViewController(withIdentifier: "HomeNoticeTableVC") as! HomeNoticeTableVC
        viewControllers.append(tableVC)
        viewControllers.append(tableVC2)
        viewControllers.append(tableVC3)
        viewControllers.append(tableVC4)
        
        self.isScrollEnabled = false
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func settingTabBar (ctBar : TMBar.ButtonBar) {
        ctBar.layout.transitionStyle = .none
        
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 13.0, bottom: 0.0, right: 20.0)
        
        // 간격
        ctBar.layout.interButtonSpacing = 35
            
        ctBar.backgroundView.style = .blur(style: .light)
        
        // 선택 / 안선택 색 + font size
        ctBar.buttons.customize { (button) in
            button.tintColor = .black
            button.selectedTintColor = .black
            button.font = UIFont.systemFont(ofSize: 11)
            button.selectedFont = UIFont.systemFont(ofSize: 11, weight: .bold)
        }
        
        // 인디케이터 (영상에서 주황색 아래 바 부분)
        ctBar.indicator.weight = .custom(value: 3)
        ctBar.indicator.tintColor = UIColor.systemGray5
    }
}
extension HomeNoticeVC: PageboyViewControllerDataSource, TMBarDataSource {
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
   
        // MARK: -Tab 안 글씨들
        switch index {
        case 0:
            return TMBarItem(title: " 전체 ")
        case 1:
            return TMBarItem(title: " 채팅 ")
        case 2:
            return TMBarItem(title: "멘토신청")
        case 3:
            return TMBarItem(title: "멘티신청")
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
