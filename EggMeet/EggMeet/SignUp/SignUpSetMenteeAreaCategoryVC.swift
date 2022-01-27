//
//  SignUpSetMenteeAreaCategoryVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit
import DropDown


class SignUpSetMenteeAreaCategoryVC : UIViewController {
    
    @IBOutlet weak var categoryButton: UIButton!
    
    @IBOutlet weak var menteeAreaButton: UIButton!
    @IBOutlet weak var menteeDetailAreaButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var menteeCategoryLabel: UILabel!
    @IBOutlet weak var menteeDetailCategoryLabel: UILabel!
    
    var mentorAreaSelectedIndex: Int = 0
    var selectCategory = ""
    let ud = UserDefaults.standard
    var isCategorySelected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menteeCategoryLabel.adjustsFontSizeToFitWidth = true
        menteeDetailCategoryLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func touchUpCategoryButton(_ sender: Any) {
        let categoryDD = DropDown()
        categoryDD.dataSource = [ "프로그래밍","외국어", "취업준비","자격증", "사진/영상촬영 및 편집", "디자인", "마케팅", "투자/재테크","작사/작곡", "경험/조언/노하우"]
        categoryDD.textColor = UIColor.black
        categoryDD.selectedTextColor = UIColor.blue
        categoryDD.backgroundColor = UIColor.white
        categoryDD.anchorView = menteeAreaButton
        categoryDD.show()
        categoryDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            mentorAreaSelectedIndex = index
            menteeCategoryLabel.text = item
            selectCategory = item + " > "
        }
        isCategorySelected = true
    }
    
    @IBAction func windSignUpSetMenteeAreaDescriptionView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaDescriptionVC") as? SignUpSetMenteeAreaDescriptionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetMenteeAreaDescriptionView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaDescriptionVC") as? SignUpSetMenteeAreaDescriptionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func touchMenteeDetailAreaButton(){
        let menteeDetailAreaDD: DropDown = DropDown()
        let detailCategoryData = [["웹프론트엔드 개발","백엔드 개발", "모바일 앱 개발", "게임 개발", "DevOps", "머신러닝", "데이터분석", "프로그래밍 언어", "기타"], ["영어","일본어", "중국어", "스페인어", "프랑스어", "독일어", "러시아어", "아랍어","이탈리아어","기타"],
        ["취업/이직 코칭", "자기소개서 코칭", "직무 스킬", "기타"],
        ["국가 공인 자격증", "기타"],["편집", "촬영", "카메라 활용", "기타"],
        ["일러스트","컨셉아트", "이모티콘", "드로잉", "캘리그라피","디자인 툴", "UI/UX", "시각디자인", "기타"],
        ["디지털/SNS 마케팅", "카피라이팅", "데이터 마케팅", "기타"],
        ["회계/세무/재무", "주식 투자", "부동산 투자", "기타"],
        ["실용음악 이론", "작곡 및 프로듀싱", "작사", "기타"],
        ["여행기", "창업 경험담", "실패 극복 경험", "취업 성공 노하우", "기타"]]
        menteeDetailAreaDD.dataSource = detailCategoryData[mentorAreaSelectedIndex]
        menteeDetailAreaDD.textColor = UIColor.black
        menteeDetailAreaDD.selectedTextColor = UIColor.blue
        menteeDetailAreaDD.backgroundColor = UIColor.white
        menteeDetailAreaDD.anchorView = menteeDetailAreaButton
        menteeDetailAreaDD.show()
        menteeDetailAreaDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            menteeDetailCategoryLabel.text = item
            selectCategory += item
            print(selectCategory)
            ud.set(selectCategory, forKey: "menteeCategory")
            self.nextButton.setImage(UIImage(named: "enable_next_button"), for: .normal)
        }
        isCategorySelected = true
    }
    
    
}
