//
//  SignUpLocationViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit
import DropDown

class SignUpLocationVC: UIViewController {
    @IBOutlet weak var locationAreaButton: UIButton!
    let locationAreaDD: DropDown = DropDown()
    let locationKey = "location"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "활동지역";
    }
    
    @IBAction func windSignUpSelfIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        
        print("다음으로")
    }
    @IBAction func skipAndWindSignUpSelfIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSelfIntroduceVC") as? SignUpSelfIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
        print("건너뛰기")
    }
    
    @IBAction func touchLocationAreaButton(){
        locationAreaDD.dataSource = [ "전체", "서울", "경기", "인천", "강원", "충남", "대전", "충북", "세종", "부산", "울산", "대구", "경북", "경남", "전남", "광주", "전북", "제주", "전국"]
        locationAreaDD.textColor = UIColor.black
        locationAreaDD.selectedTextColor = UIColor.blue
        locationAreaDD.backgroundColor = UIColor.white
        locationAreaDD.show()
        locationAreaDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            ud.set(item, forKey: locationKey)
        }
    }
}
