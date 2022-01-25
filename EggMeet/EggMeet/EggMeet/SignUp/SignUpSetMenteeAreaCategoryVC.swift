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
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchUpCategoryButton(_ sender: Any) {
        let categoryDD = DropDown()
        categoryDD.dataSource = ["프로그래밍 / 데이터 사이언스","외국어", "취업준비","자격증 / 시험", "사진 / 영상촬영 및 편집", "디자인 및 그래픽", "마케팅", "투자 / 재테크", "경험 / 조언 / 노하우"]
        categoryDD.anchorView = categoryButton
        categoryDD.show()
        categoryDD.selectionAction = { [unowned self] (index: Int, item: String) in
            NSLog("선택한 아이템 : \(item)")
            NSLog("인덱스 : \(index)")
            
        }
    }
    
    @IBAction func windSignUpSetMenteeAreaDescriptionView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaDescriptionVC") as? SignUpSetMenteeAreaDescriptionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpSetMenteeAreaDescriptionView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaDescriptionVC") as? SignUpSetMenteeAreaDescriptionVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
}
