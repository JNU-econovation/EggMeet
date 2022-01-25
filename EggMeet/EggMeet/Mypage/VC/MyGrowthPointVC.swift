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
        setGrowthpointData()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func GoToSeeGrowthStages(_ sender: UIButton) {
        
       
    }
    
    func setGrowthpointData(){
        MypageNetwork.shared.getMypageData() { data in
            
            self.MyPossessGrowthPoint.text = "\(data.growthPoint)"
            
            }
            
           
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
