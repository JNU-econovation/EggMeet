//
//  ScheduleRequestMentorSystemTableViewCell.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/26.
//

import UIKit
import Alamofire

class ScheduleRequestMentorSystemTableViewCell: UITableViewCell {

    @IBOutlet var scheduleAcceptButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func touchUpScheduleAcceptButton(_ sender: Any?){
        let ud = UserDefaults.standard
        let requestId :Int = ud.integer(forKey: "mentoringRequestId")
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL = "http://" + mainAddress + "/mentoring/meeting/request?requestId=\(requestId)"
        
        var request = URLRequest(url: URL(string: apiURL)!)
        request.httpMethod = "PUT"
        request.timeoutInterval = 10
        
        AF.request(request).responseString{(response) in
            NSLog("status code : \(response.response?.statusCode)")
            NSLog("description : \(response.debugDescription)")
        }
    }
    
}
