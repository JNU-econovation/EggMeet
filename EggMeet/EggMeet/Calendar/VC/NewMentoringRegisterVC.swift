//
//  NewMentoringRegisterVC.swift
//  EggMeet
//
//  Created by asong on 2022/01/23.
//

import Foundation
import UIKit

class NewMentoringRegisterVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func windNewMentoringCalendarVC(_ sender: Any) {
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "NewMentoringScheduleSetVC") as! NewMentoringScheduleSetVC
        self.navigationController?.pushViewController(nextVC, animated: true)
        
    }
}
