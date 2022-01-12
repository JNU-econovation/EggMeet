//
//  HomeFilterVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/12.
//

import Foundation
import UIKit
import DropDown

class HomeFilterVC: UIViewController {
    @IBOutlet weak var firstLocationButton: UIButton!
    @IBOutlet weak var secondLocationButton: UIButton!
    @IBOutlet weak var firstCategoryButton: UIButton!
    @IBOutlet weak var secondCategoryButton: UIButton!
   
    let firstLocationDD: DropDown = DropDown()
    let secondLocationDD: DropDown = DropDown()
    let firstCategoryDD: DropDown = DropDown()
    let secondCategoryDD: DropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.navigationBar.isHidden = false
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
    
    @IBAction func touchSubmitButton() {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
