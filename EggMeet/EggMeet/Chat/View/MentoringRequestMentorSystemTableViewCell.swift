//
//  MentoringRequestMentorSystemTableViewCell.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/26.
//

import UIKit

class MentoringRequestMentorSystemTableViewCell: UITableViewCell {

    @IBOutlet var mentoringAcceptButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchUpMentoringAcceptButton(_ sender: Any?){
        let ud = UserDefaults.standard
        let requestId :Int = ud.integer(forKey: "mentoringRequestId")
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL = "http://" + mainAddress + "/mentoring/request?requestId=\(requestId)"
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "GET"
    }
    
}
