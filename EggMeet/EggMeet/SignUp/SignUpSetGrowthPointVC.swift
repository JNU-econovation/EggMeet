//
//  SignUpSetGrowthPointVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/03.
//

import Foundation
import UIKit
import DropDown

class SignUpSetGrowthPointVC : UIViewController{
    
    @IBOutlet weak var setGrowthPointButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    let growthPointKey = "growthPoint"
    let ud = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = ""
    }

    @IBAction func windSignUpSetMenteeAreaCategoryView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaCategoryVC") as? SignUpSetMenteeAreaCategoryVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func windExplainGrowthPointView(_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ExplainGrowthPointVC") as? ExplainGrowthPointVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func skipAndWindSignUpSetMenteeAreaCategoryView (_ sender: Any){
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpSetMenteeAreaCategoryVC") as? SignUpSetMenteeAreaCategoryVC else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    @IBAction func touchUpSetGrowthPoint(_ sender: Any) {
        let growthPointDD = DropDown()
        growthPointDD.dataSource = ["0pt", "1pt", "2pt", "3pt", "4pt", "5pt"]
        growthPointDD.anchorView = setGrowthPointButton
        growthPointDD.show()
        growthPointDD.selectionAction = { [unowned self] (index: Int, item: String) in
            NSLog("선택한 아이템 : \(item)")
            NSLog("인덱스 : \(index)")
            ud.set(index, forKey: growthPointKey)
            NSLog("set growthPoint : \(index)")
            self.nextButton.setImage(UIImage(named: "enable_next_button"), for: .normal)
        }
    }
}
