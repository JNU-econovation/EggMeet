//
//  SignUpMentoAreaSelectionViewController.swift
//  EggMeet
//
//  Created by asong on 2022/01/01.
//

import Foundation
import UIKit
import DropDown

class SignUpMentoAreaSelectionVC: UIViewController{
    @IBOutlet weak var mentorAreaButton: UIButton!
    @IBOutlet weak var mentorDetailAreaButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var mentorCategoryLabel: UILabel!
    @IBOutlet weak var mentorDetailCategoryLabel: UILabel!
    
    let mentorAreaDD: DropDown = DropDown()
    let mentorDetailAreaDD: DropDown = DropDown()
    let mentoAreaKey = "mentorCategory"
    let mentorDetailAreaKey = "mentorDetailCategory"
    let ud = UserDefaults.standard
    var isCategorySelected: Bool = false
    let detailCategoryData = [["웹프론트엔드 개발","백엔드 개발", "모바일 앱 개발", "게임 개발", "DevOps", "머신러닝", "데이터분석", "프로그래밍 언어", "기타"], ["영어","일본어", "중국어", "스페인어", "프랑스어", "독일어", "러시아어", "아랍어","이탈리아어","기타"],
    ["취업/이직 코칭", "자기소개서 코칭", "직무 스킬", "기타"],
    ["국가 공인 자격증", "기타"],["편집", "촬영", "카메라 활용", "기타"],
    ["일러스트","컨셉아트", "이모티콘", "드로잉", "캘리그라피","디자인 툴", "UI/UX", "시각디자인", "기타"],
    ["디지털/SNS 마케팅", "카피라이팅", "데이터 마케팅", "기타"],
    ["회계/세무/재무", "주식 투자", "부동산 투자", "기타"],
    ["실용음악 이론", "작곡 및 프로듀싱", "작사", "기타"],
    ["여행기", "창업 경험담", "실패 극복 경험", "취업 성공 노하우", "기타"]]
    var mentorAreaSelectedIndex: Int = 0
    var selectCategory = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mentorCategoryLabel.adjustsFontSizeToFitWidth = true
        mentorDetailCategoryLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "멘토 분야 선택";
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func windSignUpMentoDetailIntroduceView(_ sender: Any){
        if isCategorySelected {
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoDetailIntroduceVC") as? SignUpMentoDetailIntroduceVC else {return}
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
    
    @IBAction func skipAndWindSignUpMentoDetailIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoDetailIntroduceVC") as? SignUpMentoDetailIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func touchMentorAreaButton(){
        mentorAreaDD.dataSource = [ "프로그래밍","외국어", "취업준비","자격증", "사진/영상촬영 및 편집", "디자인", "마케팅", "투자/재테크","작사/작곡", "경험/조언/노하우"]
        mentorAreaDD.textColor = UIColor.black
        mentorAreaDD.selectedTextColor = UIColor.blue
        mentorAreaDD.backgroundColor = UIColor.white
        mentorAreaDD.anchorView = mentorAreaButton
        mentorAreaDD.show()
        mentorAreaDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            ud.set(item, forKey: mentoAreaKey)
            mentorAreaSelectedIndex = index
            mentorCategoryLabel.text = item
            selectCategory = item + " > "
        }
        isCategorySelected = true
    }
    
    @IBAction func touchMentorDetailAreaButton(){
        mentorDetailAreaDD.dataSource = detailCategoryData[mentorAreaSelectedIndex]
        mentorDetailAreaDD.textColor = UIColor.black
        mentorDetailAreaDD.selectedTextColor = UIColor.blue
        mentorDetailAreaDD.backgroundColor = UIColor.white
        mentorDetailAreaDD.anchorView = mentorDetailAreaButton
        mentorDetailAreaDD.show()
        mentorDetailAreaDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            mentorDetailCategoryLabel.text = item
            selectCategory += item
            ud.set(selectCategory, forKey: mentorDetailAreaKey)
        }
        isCategorySelected = true
    }
    
}
