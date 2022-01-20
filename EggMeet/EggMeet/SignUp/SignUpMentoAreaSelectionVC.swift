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
    let mentorAreaDD: DropDown = DropDown()
    let mentoAreaKey = "mentorCategory"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "멘토 분야 선택";
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    @IBAction func windSignUpMentoDetailIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoDetailIntroduceVC") as? SignUpMentoDetailIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func skipAndWindSignUpMentoDetailIntroduceView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpMentoDetailIntroduceVC") as? SignUpMentoDetailIntroduceVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @IBAction func touchMentorAreaButton(){
        mentorAreaDD.dataSource = [ "프로그래밍 / 데이터 사이언스","외국어", "취업준비","자격증 / 시험", "사진 / 영상촬영 및 편집", "디자인 및 그래픽", "마케팅", "투자 / 재테크", "경험 / 조언 / 노하우"]
        mentorAreaDD.textColor = UIColor.black
        mentorAreaDD.selectedTextColor = UIColor.blue
        mentorAreaDD.backgroundColor = UIColor.white
        mentorAreaDD.show()
        mentorAreaDD.selectionAction = { [unowned self] (index: Int, item: String) in
            print("선택한 아이템 : \(item)")
            print("인덱스 : \(index)")
            ud.set(item, forKey: mentoAreaKey)
        }
    }
    
}
