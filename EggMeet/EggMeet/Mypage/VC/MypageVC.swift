//
//  MypageVC.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/22.
//

import UIKit

class MypageVC: UIViewController {

    @IBOutlet weak var MyPageTitle: UILabel!
    @IBOutlet weak var MyProfileContainerView: UIView!
    @IBOutlet weak var GrowthPointContainerView: UIView!
    @IBOutlet weak var MenuContainerView: UIView!
    
    
    override func viewDidLoad() {
        MyPageTitle.adjustsFontSizeToFitWidth = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToSeeMyProfile(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "ToSeeMyProfile", sender: nil)
                guard navigationController?.topViewController == self else { return }
       
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
