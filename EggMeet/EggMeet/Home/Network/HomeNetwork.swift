//
//  HomeNetwork.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation
import Alamofire

struct HomeNetwork {
    static let shared = HomeNetwork()
    let ud = UserDefaults.standard
    
    func getUserMentorData() -> UserMentorResponseModel {
        let url = getAPI_URL(target: "/user/mentor")
        NSLog("api URL : \(url)")
        
        let accessToken: String = ud.string(forKey: "accessToken")!
        print(accessToken)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 10
        
        var mentorList: UserMentorResponseModel = UserMentorResponseModel.init(age: 0, category: .PROGRAMMING_C, growthPoint: 0, location: .ALL, mentorRating: 0.0, nickname: "dd", isOfflineAvailable: true, isOnlineAvailable: true, sex: .UNDEFINED)
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer " + accessToken,
            "Content-Type": "application/json"
        ]
        

        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300).responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        print(value)
                    case .failure(let error):
                        print(error.errorDescription)
                        print(response.debugDescription)
                    }
            }

        
        /*
        AF.request(request).responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let value):
                do { let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    
                    mentorList = try JSONDecoder().decode(UserMentorResponseModel.self, from: data)
                    print("email : \(mentorList.nickname)")
                    print("result : \(mentorList.mentorRating)")
                   
                } catch { }
            case .failure(let error):
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let data = dataResponse.data, let str = String(data: data, encoding: String.Encoding.utf8){
                            print("Server Error: " + str)
                }
                debugPrint(error as Any)
                print("===========================\n\n")
            }
        }*/
        return mentorList
    }
    
    func getAPI_URL(target: String) -> String{
        let mainAddress: String = Bundle.main.infoDictionary!["API_URL"] as? String ?? ""
        let apiURL: String = "http://"+mainAddress + target
        return apiURL
    }
}
