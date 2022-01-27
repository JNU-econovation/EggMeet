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
    @IBOutlet weak var firstCategoryLabel: UILabel!
    @IBOutlet weak var secondCategoryLabel: UILabel!
    
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var channelView: UIView!
    
    let firstLocationDD: DropDown = DropDown()
    let secondLocationDD: DropDown = DropDown()
    let firstCategoryDD: DropDown = DropDown()
    let secondCategoryDD: DropDown = DropDown()
    var selectedCategoryIndex = 0
    var categoryStr = ""
    
    var location: String = ""
    var category: String = ""
    var sex: String = ""
    var age: Int = 0
    var isOnlineAvailable: Bool? = nil
    var isOfflineAvailable: Bool? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAgeRadioButtons()
        setGenderRadioButtons()
        setChannelRadioButtons()
       // let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
       // statusBar.backgroundColor = UIColor(red: 242, green: 242, blue: 242, alpha: 1)
        //UIApplication.shared.keyWindow?.addSubview(statusBar)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationItem.title = "필터"
        self.navigationController?.navigationBar.isHidden =  false
        //addShadowToBar()
       
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_bar")?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        firstCategoryLabel.adjustsFontSizeToFitWidth = true
        secondCategoryLabel.adjustsFontSizeToFitWidth = true
    }
    
    func addShadowToBar() {
        let shadowView = UIView(frame: self.navigationController!.navigationBar.frame)
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.4 // your opacity
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2) // your offset
        shadowView.layer.shadowRadius =  4 //your radius
        self.view.addSubview(shadowView)
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
        
        radioButton10.frame = CGRect(x: 0, y: 0, width: 70, height: 15)
        radioButton20.frame = CGRect(x: 60, y: 0, width: 70, height: 15)
        radioButton30.frame = CGRect(x: 0, y: 30, width: 70, height: 15)
        radioButton40.frame = CGRect(x: 60, y: 30, width: 70, height: 15)
        radioButton50.frame = CGRect(x: 0, y: 60, width: 70, height: 15)
        radioButton60.frame = CGRect(x: 60, y: 60, width: 70, height: 15)
        
        radioButton10.setTitleColor( .black , for: .normal)
        radioButton20.setTitleColor( .black , for: .normal)
        radioButton30.setTitleColor( .black , for: .normal)
        radioButton40.setTitleColor( .black , for: .normal)
        radioButton50.setTitleColor( .black , for: .normal)
        radioButton60.setTitleColor( .black , for: .normal)
        
        radioButton10.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        radioButton20.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        radioButton30.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        radioButton40.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        radioButton50.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        radioButton60.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
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
        if sender.isSelected {
            print(sender.currentTitle!)
            switch sender.currentTitle! {
            case "10대" : age = 10
            case "20대" : age = 20
            case "30대" : age = 30
            case "40대" : age = 40
            case "50대" : age = 50
            case "60대" : age = 60
            default : age = 20
            }
        }else{
            print("취소 : \(sender.currentTitle!)")
            age = 0
        }
    }
    
    func setGenderRadioButtons(){
        let womanRadioButton = DLRadioButton()
        let manradioButton = DLRadioButton()
        
        womanRadioButton.setTitle("여성", for: .normal)
        manradioButton.setTitle("남성", for: .normal)
        
        womanRadioButton.frame = CGRect(x: 0, y: 0, width: 70, height: 15)
        manradioButton.frame = CGRect(x: 60, y: 0, width: 70, height: 15)
        
        womanRadioButton.setTitleColor( .black , for: .normal)
        manradioButton.setTitleColor( .black , for: .normal)
        
        manradioButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        womanRadioButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        womanRadioButton.otherButtons.append(manradioButton)
        
        womanRadioButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        manradioButton.addTarget(self, action: #selector(touchGenderRadioButton(_:)), for: .touchUpInside)
        
        womanRadioButton.isMultipleSelectionEnabled = true
        
        genderView.addSubview(womanRadioButton)
        genderView.addSubview(manradioButton)
    }
    
    @objc func touchGenderRadioButton(_ sender:DLRadioButton) {
        if sender.isSelected {
            print(sender.currentTitle!)
            switch sender.currentTitle! {
            case "여성" : sex = "FEMALE"
            case "남성" : sex = "MALE"
            default : sex = ""
            }
        }else{
            print("취소 : \(sender.currentTitle!)")
            sex = ""
        }
    }
    
    func setChannelRadioButtons(){
        let onlineRadioButton = DLRadioButton()
        let offlineRadioButton = DLRadioButton()
        
        onlineRadioButton.setTitle("온라인", for: .normal)
        offlineRadioButton.setTitle("오프라인", for: .normal)
        
        onlineRadioButton.frame = CGRect(x: 0, y: 0, width: 70, height: 15)
        offlineRadioButton.frame = CGRect(x: 60, y: 0, width: 90, height: 15)
        
        onlineRadioButton.setTitleColor( .black , for: .normal)
        offlineRadioButton.setTitleColor( .black , for: .normal)
        
        onlineRadioButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        offlineRadioButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
        onlineRadioButton.otherButtons.append(offlineRadioButton)
        
        onlineRadioButton.addTarget(self, action: #selector(touchChannelRadioButton(_:)), for: .touchUpInside)
        offlineRadioButton.addTarget(self, action: #selector(touchChannelRadioButton(_:)), for: .touchUpInside)
        
        onlineRadioButton.isMultipleSelectionEnabled = true
        
        channelView.addSubview(onlineRadioButton)
        channelView.addSubview(offlineRadioButton)
    }
    
    @objc func touchChannelRadioButton(_ sender:DLRadioButton) {
        if sender.isSelected {
            switch sender.currentTitle! {
            case "온라인" : isOnlineAvailable = true
            case "오프라인" : isOfflineAvailable = true
            default : return
            }
            print(sender.currentTitle!)
        }else{
            switch sender.currentTitle! {
            case "온라인" : isOnlineAvailable = false
            case "오프라인" : isOfflineAvailable = false
            default : return
            }
            print("취소 : \(sender.currentTitle!)")
        }
    }
    
    @IBAction func touchFirstLocationButton(){
        firstLocationDD.dataSource = [     "ALL",
                                           "GWANGJU_BUKGU",
                                           "GWANGJU_SEOGU",
                                           "GWANGJU_NAMDONGGU",
                                           "GWANGJU_GWANGSANGU"]
        firstLocationDD.textColor = UIColor.black
        firstLocationDD.selectedTextColor = UIColor.blue
        firstLocationDD.backgroundColor = UIColor.white
        firstLocationDD.show()
        firstLocationDD.selectionAction = { [unowned self] (index: Int, item: String) in
            location = item
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
        }
    }
    
    @IBAction func touchFirstCategoryButton() {
        firstCategoryDD.dataSource = [ "프로그래밍","외국어", "취업준비","자격증", "사진/영상촬영 및 편집", "디자인", "마케팅", "투자/재테크","작사/작곡", "경험/조언/노하우"]
        firstCategoryDD.textColor = UIColor.black
        firstCategoryDD.selectedTextColor = UIColor.blue
        firstCategoryDD.backgroundColor = UIColor.white
        firstCategoryDD.anchorView = firstCategoryButton
        firstCategoryDD.show()
        firstCategoryDD.selectionAction = { [unowned self] (index: Int, item: String) in
            categoryStr = item + " > "
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            firstCategoryLabel.text = item
            selectedCategoryIndex = index
        }
    }
    
    @IBAction func touchSecondCategoryButton(){
        let detailCategoryData = [["웹프론트엔드 개발","백엔드 개발", "모바일 앱 개발", "게임 개발", "DevOps", "머신러닝", "데이터분석", "프로그래밍 언어", "기타"], ["영어","일본어", "중국어", "스페인어", "프랑스어", "독일어", "러시아어", "아랍어","이탈리아어","기타"],
        ["취업/이직 코칭", "자기소개서 코칭", "직무 스킬", "기타"],
        ["국가 공인 자격증", "기타"],["편집", "촬영", "카메라 활용", "기타"],
        ["일러스트","컨셉아트", "이모티콘", "드로잉", "캘리그라피","디자인 툴", "UI/UX", "시각디자인", "기타"],
        ["디지털/SNS 마케팅", "카피라이팅", "데이터 마케팅", "기타"],
        ["회계/세무/재무", "주식 투자", "부동산 투자", "기타"],
        ["실용음악 이론", "작곡 및 프로듀싱", "작사", "기타"],
        ["여행기", "창업 경험담", "실패 극복 경험", "취업 성공 노하우", "기타"]]
        
        secondCategoryDD.dataSource = detailCategoryData[selectedCategoryIndex]
        secondCategoryDD.textColor = UIColor.black
        secondCategoryDD.selectedTextColor = UIColor.blue
        secondCategoryDD.backgroundColor = UIColor.white
        secondCategoryDD.anchorView = secondCategoryButton
        secondCategoryDD.show()
        secondCategoryDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            secondCategoryLabel.text = item
            categoryStr += item
            print(categoryStr)
            category = categoryStr
        }
    }
}
