//
//  HomeFilterVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/12.
//

import Foundation
import UIKit
import DropDown
import DLRadioButton

class HomeFilterVC: UIViewController {
    @IBOutlet weak var firstLocationButton: UIButton!
    @IBOutlet weak var secondLocationButton: UIButton!
    @IBOutlet weak var firstCategoryButton: UIButton!
    @IBOutlet weak var secondCategoryButton: UIButton!
    
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var channelView: UIView!
    
    let firstLocationDD: DropDown = DropDown()
    let secondLocationDD: DropDown = DropDown()
    let firstCategoryDD: DropDown = DropDown()
    let secondCategoryDD: DropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAgeRadioButtons()
        setGenderRadioButtons()
        setChannelRadioButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    func setAgeRadioButtons(){
        let radioButton10 = DLRadioButton()
        let radioButton20 = DLRadioButton()
        let radioButton30 = DLRadioButton()
        let radioButton40 = DLRadioButton()
        let radioButton50 = DLRadioButton()
        let radioButton60 = DLRadioButton()
        
        radioButton10.setTitle("10대", for: .normal)
        radioButton20.setTitle("20대", for: .normal)
        radioButton30.setTitle("30대", for: .normal)
        radioButton40.setTitle("40대", for: .normal)
        radioButton50.setTitle("50대", for: .normal)
        radioButton60.setTitle("60대", for: .normal)
        
        radioButton10.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        radioButton20.frame = CGRect(x: 80, y: 0, width: 70, height: 30)
        radioButton30.frame = CGRect(x: 0, y: 40, width: 70, height: 30)
        radioButton40.frame = CGRect(x: 80, y: 40, width: 70, height: 30)
        radioButton50.frame = CGRect(x: 0, y: 80, width: 70, height: 30)
        radioButton60.frame = CGRect(x: 80, y: 80, width: 70, height: 30)
        
        radioButton10.setTitleColor( .black , for: .normal)
        radioButton20.setTitleColor( .black , for: .normal)
        radioButton30.setTitleColor( .black , for: .normal)
        radioButton40.setTitleColor( .black , for: .normal)
        radioButton50.setTitleColor( .black , for: .normal)
        radioButton60.setTitleColor( .black , for: .normal)
        
        radioButton10.otherButtons.append(radioButton20)
        radioButton10.otherButtons.append(radioButton30)
        radioButton10.otherButtons.append(radioButton40)
        radioButton10.otherButtons.append(radioButton50)
        radioButton10.otherButtons.append(radioButton60)
        
        radioButton10.addTarget(self, action: #selector(touchAgeRadioButton(_:)), for: .touchUpInside)
        radioButton20.addTarget(self, action: #selector(touchAgeRadioButton(_:)), for: .touchUpInside)
        radioButton30.addTarget(self, action: #selector(touchAgeRadioButton(_:)), for: .touchUpInside)
        radioButton40.addTarget(self, action: #selector(touchAgeRadioButton(_:)), for: .touchUpInside)
        radioButton50.addTarget(self, action: #selector(touchAgeRadioButton(_:)), for: .touchUpInside)
        radioButton60.addTarget(self, action: #selector(touchAgeRadioButton(_:)), for: .touchUpInside)
        
        
        radioButton10.isMultipleSelectionEnabled = true
        
        ageView.addSubview(radioButton10)
        ageView.addSubview(radioButton20)
        ageView.addSubview(radioButton30)
        ageView.addSubview(radioButton40)
        ageView.addSubview(radioButton50)
        ageView.addSubview(radioButton60)
    }
    
    @objc func touchAgeRadioButton(_ sender:DLRadioButton) {
        print(sender.currentTitle!)
    }
    
    func setGenderRadioButtons(){
        let womanRadioButton = DLRadioButton()
        let manradioButton = DLRadioButton()
        
        womanRadioButton.setTitle("여성", for: .normal)
        manradioButton.setTitle("남성", for: .normal)
        
        womanRadioButton.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        manradioButton.frame = CGRect(x: 80, y: 0, width: 70, height: 30)
        
        womanRadioButton.setTitleColor( .black , for: .normal)
        manradioButton.setTitleColor( .black , for: .normal)
        
        womanRadioButton.otherButtons.append(manradioButton)
        
        womanRadioButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        manradioButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        
        genderView.addSubview(womanRadioButton)
        genderView.addSubview(manradioButton)
    }
    
    @objc func touchGenderRadioButton(_ sender:DLRadioButton) {
        print(sender.currentTitle!)
    }
    
    func setChannelRadioButtons(){
        let onlineRadioButton = DLRadioButton()
        let offlineRadioButton = DLRadioButton()
        
        onlineRadioButton.setTitle("온라인", for: .normal)
        offlineRadioButton.setTitle("오프라인", for: .normal)
        
        onlineRadioButton.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        offlineRadioButton.frame = CGRect(x: 80, y: 0, width: 90, height: 30)
        
        onlineRadioButton.setTitleColor( .black , for: .normal)
        offlineRadioButton.setTitleColor( .black , for: .normal)
        
        onlineRadioButton.otherButtons.append(offlineRadioButton)
        
        onlineRadioButton.addTarget(self, action: #selector(touchChannelRadioButton(_:)), for: .touchUpInside)
        offlineRadioButton.addTarget(self, action: #selector(touchChannelRadioButton(_:)), for: .touchUpInside)
        
        channelView.addSubview(onlineRadioButton)
        channelView.addSubview(offlineRadioButton)
    }
    
    @objc func touchChannelRadioButton(_ sender:DLRadioButton) {
        print(sender.currentTitle!)
    }
    
    @IBAction func touchFirstLocationButton(){
        firstLocationDD.dataSource = [ "전체", "서울", "경기", "인천", "강원", "충남", "대전", "충북", "세종", "부산", "울산", "대구", "경북", "경남", "전남", "광주", "전북", "제주", "전국"]
        firstLocationDD.textColor = UIColor.black
        firstLocationDD.selectedTextColor = UIColor.blue
        firstLocationDD.backgroundColor = UIColor.white
        firstLocationDD.show()
        firstLocationDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
        }
    }
    
    @IBAction func touchFirstCategoryButton() {
        firstCategoryDD.dataSource = [ "프로그래밍 / 데이터 사이언스","외국어", "취업준비","자격증 / 시험", "사진 / 영상촬영 및 편집", "디자인 및 그래픽", "마케팅", "투자 / 재테크", "경험 / 조언 / 노하우"]
        firstCategoryDD.textColor = UIColor.black
        firstCategoryDD.selectedTextColor = UIColor.blue
        firstCategoryDD.backgroundColor = UIColor.white
        firstCategoryDD.show()
        firstCategoryDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
        }
    }
}
