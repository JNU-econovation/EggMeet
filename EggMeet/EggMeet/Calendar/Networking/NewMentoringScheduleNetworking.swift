//
//  NewMentoringScheduleNetworking.swift
//  EggMeet
//
//  Created by 황지우 on 2022/01/28.
//

import Foundation
import Alamofire

struct NewMentoringScheduleSetNetwork {
    
    static let shared = NewMentoringScheduleSetNetwork()
    let ud = UserDefaults.standard
    var newSchedule = Date()
    
    
    func postRequest(mentoringId: Int, newSchedule: Double, completion: @escaping (String) -> Void){
        
        let url = getAPI_URL(target: "/mentoring/"+"?mentoringId=\(mentoringId)"+"/meeting/request")
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        
        let params = ["dateTime": newSchedule] as Dictionary

                // httpBody 에 parameters 추가
                do {
                    try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
                } catch {
                    print("http Body Error")
                }
        
        AF.request(request).responseString{ (response) in
            switch response.result {
            case .success(let res):
                NSLog("response: \(response.debugDescription)")
                print("request String : \(res)")
                completion(res)
            case .failure(let error):
                NSLog("error \(error)")
            }
        }

    
        func getAPI_URL(target: String) -> String{
            let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
            let apiURL: String = "http://"+mainAddress + target
            return apiURL
        }
        
    
    }

}
