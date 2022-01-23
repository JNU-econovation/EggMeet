//
//  ScheduleCancelVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/24.
//

import Foundation
import UIKit

class ScheduleCancelVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "멘토링 일정 취소"
        self.navigationController?.navigationBar.isHidden =  false
    }
    
    @objc func dismissView(){
        dismiss(animated:true, completion: nil)
    }
    
    @IBAction func showScheduleEditAlert(_ sender: Any){
        let alert = UIAlertController(title: "멘토링 일정 취소 완료",message: "멘토링 일정을 취소했습니다. "+"\n"+"멘토에게 지급한 성장 비용이 다시 나의 성장포인트로 합산됩니다. ",preferredStyle: UIAlertController.Style.alert)
         //확인 버튼 만들기
         let ok = UIAlertAction(title: "확인", style: .default, handler: {
             action in
             //특정기능 수행
             self.dismissView()
         })
         //확인 버튼 경고창에 추가하기
         alert.addAction(ok)
         present(alert,animated: true,completion: nil)
     }
}
