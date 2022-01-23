//
//  MyGrowthPointVC.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/22.
//

import UIKit

class MyGrowthPointVC: UIViewController {

    
    @IBOutlet weak var MyGrowthPointImage: UIImageView!
    
    
    @IBOutlet weak var MyGrowthStageLabel: UILabel!
    
   
    @IBOutlet weak var MyPossessGrowthPoint: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyPossessGrowthPoint.adjustsFontSizeToFitWidth = true

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GoToSeeGrowthStages(_ sender: Any) {
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
